from firebase_admin import messaging


class FirebaseService:
    @staticmethod
    def _enviar_para_tokens(tokens, titulo, corpo, dados=None):
        if not tokens:
            return

        mensagem = messaging.MulticastMessage(
            notification=messaging.Notification(title=titulo, body=corpo),
            data=dados or {},
            tokens=tokens
        )

        return messaging.send_multicast(mensagem)
    

    @staticmethod
    def novo_seguidor(usuario_destino, usuario_origem):
        tokens = list(usuario_destino.dispositivos.values_list("token", flat=True))

        titulo = "Novo seguidor"
        corpo = f"{usuario_origem.username} começou a seguir você."

        return FirebaseService._enviar_para_tokens(
            tokens,
            titulo,
            corpo,
            dados={
                "tipo": "seguimento",
                "usuario_id": str(usuario_origem.id)
            }
        )


    @staticmethod
    def nova_reacao(usuario_destino, usuario_origem, publicacao, tipo):
        tokens = list(usuario_destino.dispositivos.values_list("token", flat=True))

        if tipo == "LIKE":
            acao = "curtiu"
        else:
            acao = "não curtiu"

        titulo = "Nova reação"
        corpo = f"{usuario_origem.username} {acao} sua publicação."

        return FirebaseService._enviar_para_tokens(
            tokens,
            titulo,
            corpo,
            dados={
                "tipo": "reacao",
                "publicacao_id": str(publicacao.id),
                "usuario_id": str(usuario_origem.id)
            }
        )


    @staticmethod
    def novo_comentario(usuario_destino, usuario_origem, publicacao):
        tokens = list(usuario_destino.dispositivos.values_list("token", flat=True))

        titulo = "Novo comentário"
        corpo = f"{usuario_origem.username} comentou sua publicação."

        return FirebaseService._enviar_para_tokens(
            tokens,
            titulo,
            corpo,
            dados={
                "tipo": "comentario",
                "publicacao_id": str(publicacao.id),
                "usuario_id": str(usuario_origem.id)
            }
        )