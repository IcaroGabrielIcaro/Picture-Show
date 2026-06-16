from rest_framework import (status, views, viewsets, mixins)
from rest_framework.response import Response
from rest_framework.decorators import action
from rest_framework.parsers import MultiPartParser, FormParser
from drf_spectacular.utils import extend_schema
from rest_framework_simplejwt.views import TokenObtainPairView

from .models import (Usuario, Publicacao, Comentario, Seguidor, Reacao)
from .serializers import (LoginSerializer, UsuarioCadastroSerializer, UsuarioSerializer, PublicacaoSerializer, ComentarioSerializer)
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
        Seguidor.objects.get_or_create(seguidor=request.user, seguindo=usuario)
        return Response(status=status.HTTP_204_NO_CONTENT)

    @seguir.mapping.delete
    def deixar_de_seguir(self, request, pk=None):
        usuario = self.get_object()
        Seguidor.objects.filter(seguidor=request.user, seguindo=usuario).delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


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

        Reacao.objects.update_or_create(
            usuario=request.user,
            publicacao=publicacao,
            defaults={"tipo": tipo}
        )

        return Response(status=status.HTTP_204_NO_CONTENT)

    @reagir.mapping.delete
    def remover_reacao(self, request, pk=None):
        publicacao = self.get_object()
        Reacao.objects.filter(usuario=request.user, publicacao=publicacao).delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class ComentarioViewSet(viewsets.ModelViewSet):

    queryset = (
        Comentario.objects
        .select_related("autor")
        .select_related("publicacao")
    )

    serializer_class = ComentarioSerializer

    permission_classes = [ReadOnlyOrAuthenticated, IsAuthorOrStaffOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(autor=self.request.user)