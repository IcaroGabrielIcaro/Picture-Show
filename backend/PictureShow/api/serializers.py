from rest_framework import serializers
from .models import Postagem, PostImagem, Curtida, Follow
from auths.models import Usuario


class PostImagemSerializer(serializers.ModelSerializer):
    class Meta:
        model = PostImagem
        fields = ['url']


class PostagemSerializer(serializers.ModelSerializer):
    imagens = PostImagemSerializer(many=True)
    total_curtidas = serializers.SerializerMethodField()
    autor_username = serializers.CharField(source='autor.username', read_only=True)

    class Meta:
        model = Postagem
        fields = ['id', 'autor', 'autor_username', 'descricao', 'imagens', 'total_curtidas']
        read_only_fields = ['autor']

    def get_total_curtidas(self, obj):
        return obj.curtidas.count()

    def create(self, validated_data):
        imagens_data = validated_data.pop('imagens')
        user = self.context['request'].user

        post = Postagem.objects.create(autor=user, **validated_data)

        for img in imagens_data:
            PostImagem.objects.create(post=post, **img)

        return post

    def update(self, instance, validated_data):
        imagens_data = validated_data.pop('imagens', None)

        instance.descricao = validated_data.get('descricao', instance.descricao)
        instance.save()

        if imagens_data is not None:
            instance.imagens.all().delete()
            for img in imagens_data:
                PostImagem.objects.create(post=instance, **img)

        return instance