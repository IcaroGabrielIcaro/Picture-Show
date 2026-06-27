from rest_framework import serializers
from .models import Usuario, Seguidor, Comentario, Publicacao, Reacao
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
    
    def validate(self, attrs):
        data = super().validate(attrs)
        data["usuario"] = UsuarioSerializer(self.user, context={"request": self.context.get("request")}).data

        return data


class UsuarioCadastroSerializer(serializers.ModelSerializer):
    senha = serializers.CharField(write_only=True, min_length=6)
    imagem = serializers.ImageField(required=False)

    class Meta:
        model = Usuario
        fields = ("id", "username", "nome", "bio", "imagem", "senha")

    def create(self, validated_data):
        senha = validated_data.pop("senha")
        return Usuario.objects.create_user(password=senha, **validated_data)


class UsuarioSerializer(serializers.ModelSerializer):
    seguidores = serializers.IntegerField(source="total_seguidores", read_only=True)
    seguindo = serializers.IntegerField(source="total_seguindo", read_only=True)
    publicacoes = serializers.IntegerField(source="total_publicacoes", read_only=True)
    eu_sigo = serializers.SerializerMethodField()

    class Meta:
        model = Usuario
        fields = ("id", "username", "nome", "bio", "imagem", "seguidores", "seguindo", "publicacoes", "eu_sigo")

    def get_eu_sigo(self, obj):
        request = self.context.get("request")

        if not request or not request.user.is_authenticated:
            return False

        if request.user == obj:
            return None

        return Seguidor.objects.filter(seguidor=request.user, seguindo=obj).exists()
    

class UsuarioResumoSerializer(serializers.ModelSerializer):

    class Meta:
        model = Usuario
        fields = ("id", "username", "nome", "imagem")


class ComentarioSerializer(serializers.ModelSerializer):
    autor = UsuarioResumoSerializer(read_only=True)

    class Meta:
        model = Comentario
        fields = ("id", "autor", "mensagem", "publicado_em")


class PublicacaoSerializer(serializers.ModelSerializer):
    autor = UsuarioResumoSerializer(read_only=True)
    likes = serializers.SerializerMethodField()
    dislikes = serializers.SerializerMethodField()
    comentarios = serializers.SerializerMethodField()
    minha_reacao = serializers.SerializerMethodField()

    class Meta:
        model = Publicacao
        fields = ("id", "descricao", "imagem", "autor", "likes", "dislikes", "comentarios", "minha_reacao", "publicado_em")

    def get_likes(self, obj):
        return obj.reacoes.filter(tipo=Reacao.LIKE).count()

    def get_dislikes(self, obj):
        return obj.reacoes.filter(tipo=Reacao.DISLIKE).count()

    def get_comentarios(self, obj):
        return obj.comentarios.count()

    def get_minha_reacao(self, obj):

        request = self.context.get("request")

        if not request:
            return None

        if not request.user.is_authenticated:
            return None

        reacao = obj.reacoes.filter(usuario=request.user).first()

        if not reacao:
            return None

        return reacao.tipo
    

class RegistroTokenSerializer(serializers.Serializer):
    token = serializers.CharField()