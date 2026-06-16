from django.test import TestCase
from api.serializers import UsuarioCadastroSerializer, PublicacaoSerializer
from api.models import Usuario, Publicacao, Reacao, Comentario


class UsuarioCadastroSerializerTest(TestCase):

    def test_password_too_short(self):

        serializer = UsuarioCadastroSerializer(
            data={
                "username": "icaro",
                "nome": "Icaro",
                "senha": "123"
            }
        )

        self.assertFalse(serializer.is_valid())
        self.assertIn("senha", serializer.errors)

    def test_username_is_required(self):

        serializer = UsuarioCadastroSerializer(
            data={
                "nome": "Icaro",
                "senha": "123456"
            }
        )

        self.assertFalse(serializer.is_valid())

    def test_nome_is_required(self):

        serializer = UsuarioCadastroSerializer(
            data={
                "username": "icaro",
                "senha": "123456"
            }
        )

        self.assertFalse(serializer.is_valid())

    def test_create_hashes_password(self):

        serializer = UsuarioCadastroSerializer(
            data={
                "username": "icaro",
                "nome": "Icaro",
                "senha": "123456"
            }
        )

        self.assertTrue(serializer.is_valid())

        user = serializer.save()

        self.assertTrue(
            user.check_password("123456")
        )

    def test_likes_count(self):

        autor = Usuario.objects.create_user(
            username="autor",
            password="123456"
        )

        user = Usuario.objects.create_user(
            username="user",
            password="123456"
        )

        post = Publicacao.objects.create(
            descricao="teste",
            autor=autor
        )

        Reacao.objects.create(
            usuario=user,
            publicacao=post,
            tipo=Reacao.LIKE
        )

        data = PublicacaoSerializer(post).data

        self.assertEqual(data["likes"], 1)

    def test_comment_count(self):

        autor = Usuario.objects.create_user(
            username="autor",
            password="123456"
        )

        post = Publicacao.objects.create(
            descricao="teste",
            autor=autor
        )

        Comentario.objects.create(
            autor=autor,
            publicacao=post,
            mensagem="oi"
        )

        data = PublicacaoSerializer(post).data

        self.assertEqual(data["comentarios"], 1)

    def test_minha_reacao_without_request(self):

        autor = Usuario.objects.create_user(
            username="autor",
            password="123456"
        )

        post = Publicacao.objects.create(
            descricao="teste",
            autor=autor
        )

        data = PublicacaoSerializer(post).data

        self.assertIsNone(data["minha_reacao"])

    def test_bio_null(self):

        serializer = UsuarioCadastroSerializer(
            data={
                "username": "icaro",
                "nome": "Icaro",
                "senha": "123456",
                "bio": None
            }
        )

        self.assertFalse(serializer.is_valid())

    