from rest_framework import (status, views, viewsets, mixins)
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.parsers import MultiPartParser, FormParser
from drf_spectacular.utils import extend_schema
from rest_framework_simplejwt.views import TokenObtainPairView
from .firebase import FirebaseService

from .models import (Usuario, Publicacao, Comentario, Seguidor, Reacao, Dispositivo)
from .serializers import (LoginSerializer, UsuarioCadastroSerializer, UsuarioSerializer, PublicacaoSerializer, ComentarioSerializer, RegistroTokenSerializer)
from .permissions import (ReadOnlyOrAuthenticated, IsAuthorOrStaffOrReadOnly, IsSelfOrReadOnly)


@extend_schema(tags=["autenticação"])
class LoginView(TokenObtainPairView):
    serializer_class = LoginSerializer


class SignupView(views.APIView):
    parser_classes = [MultiPartParser, FormParser]

    @extend_schema(
        tags=["autenticação"],
        request=UsuarioCadastroSerializer,
        responses={status.HTTP_201_CREATED: UsuarioSerializer}
    )
    def post(self, request):
        serializer = UsuarioCadastroSerializer(data=request.data)

        if serializer.is_valid():
            usuario = serializer.save()

            return Response(
                UsuarioSerializer(
                    usuario,
                    context={"request": request}
                ).data,
                status=status.HTTP_201_CREATED
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UsuarioViewSet(mixins.ListModelMixin, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, viewsets.GenericViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer
    parser_classes = [MultiPartParser,FormParser]
    permission_classes = [IsSelfOrReadOnly]

    @action(detail=True,methods=["post"])
    def seguir(self, request, pk=None):
        usuario = self.get_object()
        _, created = Seguidor.objects.get_or_create(seguidor=request.user, seguindo=usuario)

        if created:
            FirebaseService.novo_seguidor(usuario_destino=usuario, usuario_origem=request.user)

        return Response(status=status.HTTP_204_NO_CONTENT)

    @seguir.mapping.delete
    def deixar_de_seguir(self, request, pk=None):
        usuario = self.get_object()
        Seguidor.objects.filter(seguidor=request.user, seguindo=usuario).delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
    
    def get_permissions(self):
        if self.action in ["seguir", "deixar_de_seguir"]:
            return [ReadOnlyOrAuthenticated()]

        return [permission() for permission in self.permission_classes]


class PublicacaoViewSet(viewsets.ModelViewSet):

    queryset = (
        Publicacao.objects
        .select_related("autor")
        .prefetch_related(
            "comentarios",
            "reacoes"
        )
    )

    serializer_class = PublicacaoSerializer
    parser_classes = [MultiPartParser, FormParser]
    permission_classes = [ReadOnlyOrAuthenticated, IsAuthorOrStaffOrReadOnly]

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context["request"] = self.request
        return context

    def perform_create(self, serializer):
        serializer.save(autor=self.request.user)

    @action(detail=True, methods=["post"])
    def reagir(self, request, pk=None):
        publicacao = self.get_object()

        tipo = request.data.get("tipo")

        if tipo not in (Reacao.LIKE, Reacao.DISLIKE):
            return Response(
                {"erro": "Tipo inválido."},
                status=status.HTTP_400_BAD_REQUEST
            )

        reacao, _ = Reacao.objects.update_or_create(
            usuario=request.user,
            publicacao=publicacao,
            defaults={"tipo": tipo}
        )

        if publicacao.autor != request.user:
            FirebaseService.nova_reacao(
                usuario_destino=publicacao.autor,
                usuario_origem=request.user,
                publicacao=publicacao,
                tipo=reacao.tipo
            )

        return Response(status=status.HTTP_204_NO_CONTENT)

    @reagir.mapping.delete
    def remover_reacao(self, request, pk=None):
        publicacao = self.get_object()
        Reacao.objects.filter(usuario=request.user, publicacao=publicacao).delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
    
    def get_permissions(self):

        if self.action in ["reagir", "remover_reacao"]:
            return [ReadOnlyOrAuthenticated()]

        return [permission() for permission in self.permission_classes]


class ComentarioViewSet(viewsets.ModelViewSet):

    queryset = (
        Comentario.objects
        .select_related("autor")
        .select_related("publicacao")
    )

    serializer_class = ComentarioSerializer

    permission_classes = [ReadOnlyOrAuthenticated, IsAuthorOrStaffOrReadOnly]

    def perform_create(self, serializer):
        comentario =  serializer.save(autor=self.request.user)

        if comentario.publicacao.autor != self.request.user:
            FirebaseService.novo_comentario(
                usuario_destino=comentario.publicacao.autor,
                usuario_origem=self.request.user,
                publicacao=comentario.publicacao
            )


@extend_schema(tags=["firebase"])
class RegistroTokenView(views.APIView):
    permission_classes = [ReadOnlyOrAuthenticated]

    @extend_schema(request=RegistroTokenSerializer, responses={200: None})
    def post(self, request):
        serializer = RegistroTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        Dispositivo.objects.update_or_create(
            token=serializer.validated_data["token"],
            defaults={
                "usuario": request.user
            }
        )

        return Response(
            {"mensagem": "Token registrado com sucesso."},
            status=status.HTTP_200_OK
        )