from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager

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
    seguidores = models.PositiveIntegerField(default=0)
    seguindo = models.PositiveIntegerField(default=0)

    first_name = None
    last_name = None

    objects = UserManager()

    def __str__(self):
        return self.username