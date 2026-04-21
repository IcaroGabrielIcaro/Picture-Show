from django.db import models
from django.conf import settings

Usuario = settings.AUTH_USER_MODEL


class Postagem(models.Model):
    autor = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name='posts')
    descricao = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def total_curtidas(self):
        return self.curtidas.count()


class PostImagem(models.Model):
    post = models.ForeignKey(Postagem, on_delete=models.CASCADE, related_name='imagens')
    url = models.URLField()


class Curtida(models.Model):
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    post = models.ForeignKey(Postagem, on_delete=models.CASCADE, related_name='curtidas')

    class Meta:
        unique_together = ('usuario', 'post')


class Follow(models.Model):
    seguidor = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name='seguindo')
    seguido = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name='seguidores')

    class Meta:
        unique_together = ('seguidor', 'seguido')