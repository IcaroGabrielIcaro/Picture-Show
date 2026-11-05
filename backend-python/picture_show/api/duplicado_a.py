def obter_usuario_autenticado(request):
    if not request:
        return None

    if not request.user.is_authenticated:
        return None

    usuario = request.user
    username = usuario.username
    email = usuario.email

    return usuario