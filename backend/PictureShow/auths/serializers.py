from rest_framework import serializers
from .models import Usuario

class UsuarioSerializer(serializers.ModelSerializer):
    seguidores_count = serializers.SerializerMethodField()
    seguindo_count = serializers.SerializerMethodField()

    class Meta:
        model = Usuario
        fields = ['id', 'username', 'bio', 'foto_perfil', 'seguidores_count', 'seguindo_count']

    def get_seguidores_count(self, obj):
        return obj.seguidores.count()

    def get_seguindo_count(self, obj):
        return obj.seguindo.count()
        

class CadastroUsuarioSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, min_length=6)
    password_confirm = serializers.CharField(write_only=True, min_length=6)

    class Meta:
        model = Usuario
        fields = ['username', 'email', 'password', 'password_confirm', 'bio', 'foto_perfil']

    def validate(self, data):
        if data['password'] != data['password_confirm']:
            raise serializers.ValidationError("As senhas não coincidem.")
        return data

    def create(self, validated_data):
        validated_data.pop('password_confirm')

        user = Usuario.objects.create_user(
            username=validated_data['username'],
            email=validated_data.get('email'),
            password=validated_data['password'],
            bio=validated_data.get('bio', ''),
            foto_perfil=validated_data.get('foto_perfil', '')
        )

        return user