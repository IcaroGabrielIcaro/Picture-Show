from rest_framework import permissions, status, viewsets
from rest_framework.decorators import api_view, permission_classes, action
from .serializers import CadastroUsuarioSerializer, UsuarioSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.response import Response
from .models import Usuario
from .utils import IsOwnerOrReadOnly

class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    serializer_class = UsuarioSerializer
    permission_classes = [permissions.IsAuthenticated, IsOwnerOrReadOnly]

    @action(detail=True, methods=['post'])
    def seguir(self, request, pk=None):
        usuario_logado = request.user
        usuario_alvo = self.get_object()

        if usuario_logado == usuario_alvo:
            return Response(
                {'error': 'Você não pode seguir a si mesmo'},
                status=status.HTTP_400_BAD_REQUEST
            )

        follow, created = Follow.objects.get_or_create(
            seguidor=usuario_logado,
            seguido=usuario_alvo
        )

        if not created:
            follow.delete()
            return Response({'status': 'deixou de seguir'})

        return Response({'status': 'seguindo'})


@api_view(['POST'])
@permission_classes([permissions.AllowAny])
def cadastro_usuario_view(request):
    """
    Endpoint para cadastro de novos usuários
    POST /api/cadastro

    Body esperado:
    {
        "username": "icaro",
        "email": "icaro@email.com",
        "password": "senha123",
        "password_confirm": "senha123",
        "foto_perfil": "url...",
        "bio": "minha bio"
    }
    """

    serializer = CadastroUsuarioSerializer(data=request.data)

    if serializer.is_valid():
        usuario = serializer.save()

        refresh = RefreshToken.for_user(usuario)

        return Response({
            'message': 'Usuário cadastrado com sucesso!',
            'user': UsuarioSerializer(usuario).data,
            'tokens': {
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            }
        }, status=status.HTTP_201_CREATED)
    
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    