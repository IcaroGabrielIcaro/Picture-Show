from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase

from api.models import (Usuario, Publicacao, Seguidor, Reacao)

class AuthViewsTest(APITestCase):

    def test_signup_success(self):

        response = self.client.post(
            reverse("sign-up"),
            {
                "username": "icaro",
                "nome": "Icaro",
                "senha": "123456"
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

        self.assertTrue(
            Usuario.objects.filter(
                username="icaro"
            ).exists()
        )

    def test_signup_password_too_short(self):

        response = self.client.post(
            reverse("sign-up"),
            {
                "username": "icaro",
                "nome": "Icaro",
                "senha": "123"
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_400_BAD_REQUEST
        )

    def test_login_success(self):

        Usuario.objects.create_user(
            username="icaro",
            password="123456",
            nome="Icaro"
        )

        response = self.client.post(
            reverse("token_obtain_pair"),
            {
                "username": "icaro",
                "password": "123456"
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

        self.assertIn("access", response.data)
        self.assertIn("refresh", response.data)
        self.assertIn("usuario", response.data)

    def test_login_invalid_password(self):

        Usuario.objects.create_user(
            username="icaro",
            password="123456",
            nome="Icaro"
        )

        response = self.client.post(
            reverse("token_obtain_pair"),
            {
                "username": "icaro",
                "password": "senha_errada"
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_401_UNAUTHORIZED
        )

class UsuarioViewSetTest(APITestCase):

    def setUp(self):

        self.user = Usuario.objects.create_user(
            username="user",
            password="123456",
            nome="User"
        )

        self.outro = Usuario.objects.create_user(
            username="outro",
            password="123456",
            nome="Outro"
        )

    def test_list_users(self):

        response = self.client.get(
            reverse("usuarios-list")
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

    def test_retrieve_user(self):

        response = self.client.get(
            reverse("usuarios-detail", args=[self.user.id])
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

    def test_follow_user(self):

        self.client.force_authenticate(
            user=self.user
        )

        response = self.client.post(
            reverse("usuarios-seguir", args=[self.outro.id])
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_204_NO_CONTENT
        )

        self.assertTrue(
            Seguidor.objects.filter(
                seguidor=self.user,
                seguindo=self.outro
            ).exists()
        )

    def test_unfollow_user(self):

        Seguidor.objects.create(
            seguidor=self.user,
            seguindo=self.outro
        )

        self.client.force_authenticate(
            user=self.user
        )

        response = self.client.delete(
            reverse("usuarios-seguir", args=[self.outro.id])
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_204_NO_CONTENT
        )

        self.assertFalse(
            Seguidor.objects.filter(
                seguidor=self.user,
                seguindo=self.outro
            ).exists()
        )

class PublicacaoViewSetTest(APITestCase):

    def setUp(self):

        self.user = Usuario.objects.create_user(
            username="autor",
            password="123456",
            nome="Autor"
        )

        self.outro = Usuario.objects.create_user(
            username="user",
            password="123456",
            nome="User"
        )

        self.post = Publicacao.objects.create(
            descricao="teste",
            autor=self.user
        )

    def test_list_publicacoes(self):

        response = self.client.get(
            reverse("publicacoes-list")
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_200_OK
        )

    def test_create_publicacao(self):

        self.client.force_authenticate(
            user=self.user
        )

        response = self.client.post(
            reverse("publicacoes-list"),
            {
                "descricao": "nova publicacao"
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_201_CREATED
        )

    def test_like_publicacao(self):

        self.client.force_authenticate(
            user=self.outro
        )

        response = self.client.post(
            reverse("publicacoes-reagir", args=[self.post.id]),
            {
                "tipo": Reacao.LIKE
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_204_NO_CONTENT
        )

        self.assertTrue(
            Reacao.objects.filter(
                usuario=self.outro,
                publicacao=self.post
            ).exists()
        )

    def test_invalid_reaction(self):

        self.client.force_authenticate(
            user=self.outro
        )

        response = self.client.post(
            reverse("publicacoes-reagir", args=[self.post.id]),
            {
                "tipo": "qualquer_coisa"
            }
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_400_BAD_REQUEST
        )

    def test_remove_reaction(self):

        Reacao.objects.create(
            usuario=self.outro,
            publicacao=self.post,
            tipo=Reacao.LIKE
        )

        self.client.force_authenticate(
            user=self.outro
        )

        response = self.client.delete(
            reverse("publicacoes-reagir", args=[self.post.id])
        )

        self.assertEqual(
            response.status_code,
            status.HTTP_204_NO_CONTENT
        )

        self.assertFalse(
            Reacao.objects.filter(
                usuario=self.outro,
                publicacao=self.post
            ).exists()
        )
