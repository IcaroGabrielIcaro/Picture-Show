from rest_framework import serializers
from .models import Usuario
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

class LoginSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        token['username'] = user.username
        token['nome'] = user.nome
        token['email'] = user.email
        token['admin'] = user.is_superuser

        return token


class UsuarioSerializer(serializers.ModelSerializer):
    senha = serializers.CharField(write_only=True)
    imagem = serializers.ImageField(required=False)

    class Meta:
        model = Usuario
        fields = ('id', 'username', 'nome', 'bio', 'imagem', 'senha')

    def create(self, validated_data):
        senha = validated_data.pop('senha')
        usuario = Usuario.objects.create_user(password=senha, **validated_data)
        return usuario