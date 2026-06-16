from django.urls import path, include
from rest_framework import routers
from drf_spectacular.views import (SpectacularAPIView, SpectacularSwaggerView)

from .views import (LoginView, SignupView, UsuarioViewSet, PublicacaoViewSet, ComentarioViewSet)

router = routers.DefaultRouter()
router.register("usuarios", UsuarioViewSet, basename="usuarios")
router.register("publicacoes", PublicacaoViewSet, basename="publicacoes")
router.register("comentarios", ComentarioViewSet, basename="comentarios")

urlpatterns = [
    path("", include(router.urls)),
    path("api-auth/", include("rest_framework.urls", namespace="rest_framework")),
    path("api/schema/", SpectacularAPIView.as_view(), name="schema"),
    path("api/doc/", SpectacularSwaggerView.as_view(url_name="schema"), name="swagger-ui"),
    path("cadastrar/", SignupView.as_view(), name="sign-up"),
    path("login/", LoginView.as_view(), name="token_obtain_pair"),
]