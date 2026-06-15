from rest_framework import status, views
from rest_framework.response import Response
from drf_spectacular.utils import extend_schema
from rest_framework_simplejwt.views import TokenObtainPairView
from .serializers import LoginSerializer, UsuarioSerializer

@extend_schema(tags=["autenticação"])
class LoginView(TokenObtainPairView):
    serializer_class = LoginSerializer


class SignupView(views.APIView):
    @extend_schema(
        tags=["autenticação"],
        request=UsuarioSerializer,
        responses={status.HTTP_201_CREATED: UsuarioSerializer}
    )
    def post(self, request):
        serializer = UsuarioSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)