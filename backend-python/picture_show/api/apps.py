import os

from django.apps import AppConfig
from django.conf import settings

import firebase_admin
from firebase_admin import credentials


class ApiConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "api"

    def ready(self):
        if firebase_admin._apps:
            return

        caminho_credenciais = os.path.join(
            settings.BASE_DIR,
            "picture_show",
            "firebase",
            "picture-show-firebase-service.json"
        )

        cred = credentials.Certificate(caminho_credenciais)
        firebase_admin.initialize_app(cred)

        print("Firebase inicializado com sucesso.")