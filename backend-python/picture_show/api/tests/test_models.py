from django.test import TestCase
from django.db import IntegrityError
from api.models import Usuario, Seguidor, Reacao, Publicacao, Comentario


class UsuarioModelTest(TestCase):

    def test_create_user_without_username(self):
        with self.assertRaises(ValueError):
            Usuario.objects.create_user(username="", password="123456")

    def test_password_is_hashed(self):
        user = Usuario.objects.create_user(username="icaro", password="123456")

        self.assertNotEqual(user.password, "123456")
        self.assertTrue(user.check_password("123456"))

    def test_user_cannot_follow_himself(self):
        user = Usuario.objects.create_user(username="teste", password="123456")

        with self.assertRaises(IntegrityError):
            Seguidor.objects.create(seguidor=user, seguindo=user)

    def test_duplicate_follow_should_fail(self):
        a = Usuario.objects.create_user(username="a", password="123456")
        b = Usuario.objects.create_user(username="b", password="123456")

        Seguidor.objects.create(seguidor=a, seguindo=b)

        with self.assertRaises(IntegrityError):
            Seguidor.objects.create(seguidor=a, seguindo=b)

    def test_duplicate_follow_should_fail(self):
        a = Usuario.objects.create_user(username="a", password="123456")
        b = Usuario.objects.create_user(username="b", password="123456")

        Seguidor.objects.create(seguidor=a, seguindo=b)

        with self.assertRaises(IntegrityError):
            Seguidor.objects.create(seguidor=a, seguindo=b)

    def test_duplicate_reaction_should_fail(self):
        autor = Usuario.objects.create_user(username="autor", password="123456")
        usuario = Usuario.objects.create_user(username="user", password="123456")
        post = Publicacao.objects.create(descricao="teste", autor=autor)

        Reacao.objects.create(usuario=usuario, publicacao=post, tipo=Reacao.LIKE)

        with self.assertRaises(IntegrityError):
            Reacao.objects.create(usuario=usuario, publicacao=post, tipo=Reacao.DISLIKE)

    def test_publicacao_allows_empty_description(self):

        user = Usuario.objects.create_user(
            username="autor",
            password="123456"
        )

        post = Publicacao.objects.create(
            descricao="",
            autor=user
        )

        self.assertEqual(post.descricao, "")

    def test_comment_allows_empty_message(self):

        autor = Usuario.objects.create_user(
            username="autor",
            password="123456"
        )

        post = Publicacao.objects.create(
            descricao="teste",
            autor=autor
        )

        comentario = Comentario.objects.create(
            autor=autor,
            publicacao=post,
            mensagem=""
        )

        self.assertEqual(comentario.mensagem, "")