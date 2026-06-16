from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager
from django.utils import timezone
from django.db.models import Q

class UserManager(BaseUserManager):
    def create_user(self, username, password=None, **extra_fields):
        if not username:
            raise ValueError("O campo 'username' é obrigatório.")

        user = self.model(username=username, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, username, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError("O superusuário deve ter is_staff=True.")

        if extra_fields.get('is_superuser') is not True:
            raise ValueError("O superusuário deve ter is_superuser=True.")

        return self.create_user(username, password, **extra_fields)


class Usuario(AbstractUser):
    nome = models.CharField(max_length=30)
    bio = models.TextField(blank=True, default="")
    imagem = models.ImageField(upload_to="api/static/", null=True, blank=True)

    first_name = None
    last_name = None

    objects = UserManager()

    @property
    def total_seguidores(self):
        return self.meus_seguidores.count()

    @property
    def total_seguindo(self):
        return self.usuarios_que_sigo.count()

    @property
    def total_publicacoes(self):
        return self.publicacoes.count()

    def __str__(self):
        return self.username
    

class Publicacao(models.Model):
    descricao = models.CharField(max_length=1200)
    imagem = models.ImageField(upload_to="api/static/", null=True, blank=True)
    autor = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name="publicacoes")
    publicado_em = models.DateTimeField(default=timezone.now)

    class Meta:
        ordering = ["-publicado_em"]

    def __str__(self):
        return f"Post #{self.id}"
    

class Comentario(models.Model):
    autor = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name="comentarios")
    publicacao = models.ForeignKey(Publicacao, on_delete=models.CASCADE, related_name="comentarios")
    mensagem = models.CharField(max_length=400)
    publicado_em = models.DateTimeField(default=timezone.now)

    class Meta:
        ordering = ["-publicado_em"]

    
class Seguidor(models.Model):
    seguidor = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name="usuarios_que_sigo")
    seguindo = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name="meus_seguidores")

    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=["seguidor", "seguindo"],
                name="unique_follow"
            ),

            models.CheckConstraint(
                condition=~Q(seguidor=models.F("seguindo")),
                name="cannot_follow_yourself"
            )
        ]


class Reacao(models.Model):

    LIKE = "LIKE"
    DISLIKE = "DISLIKE"

    TIPOS = [(LIKE, "Like"), (DISLIKE, "Dislike")]

    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name="reacoes")
    publicacao = models.ForeignKey(Publicacao, on_delete=models.CASCADE, related_name="reacoes")
    tipo = models.CharField(max_length=10, choices=TIPOS)

    criado_em = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=["usuario", "publicacao"],
                name="unique_reacao"
            )
        ]