from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import PostagemViewSet

router = DefaultRouter()
router.register(r'posts', PostagemViewSet, basename='posts')

urlpatterns = [
    path('', include(router.urls)),
]