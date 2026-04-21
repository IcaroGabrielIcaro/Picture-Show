from django.db import models
from django.contrib.auth.models import AbstractUser

class Usuario(AbstractUser):

    foto_perfil = models.URLField(blank=True)
    bio = models.TextField(blank=True)

    def __str__(self):
        return self.username or self.email