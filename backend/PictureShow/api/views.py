from rest_framework import viewsets, permissions
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Postagem, Curtida, Follow
from .serializers import PostagemSerializer
from .utils import IsOwner
from auths.models import Usuario


class PostagemViewSet(viewsets.ModelViewSet):
    queryset = Postagem.objects.all().order_by('-created_at')
    serializer_class = PostagemSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(autor=self.request.user)

    def get_permissions(self):
        if self.action in ['update', 'partial_update', 'destroy']:
            return [permissions.IsAuthenticated(), IsOwner()]
        return super().get_permissions()

    @action(detail=True, methods=['post'])
    def curtir(self, request, pk=None):
        post = self.get_object()
        user = request.user

        curtida, created = Curtida.objects.get_or_create(usuario=user, post=post)

        if not created:
            curtida.delete()
            return Response({'status': 'descurtido'})

        return Response({'status': 'curtido'})