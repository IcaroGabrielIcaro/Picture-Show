import org.springframework.stereotype.Service

@Service
class UsuarioService(
    private val usuarioRepository: UsuarioRepository
) {

    fun criar(usuario: Usuario): Usuario {
        if (usuarioRepository.existsByNomeUsuario(usuario.nomeUsuario)) {
            throw RuntimeException("Usuário já existe")
        }
        return usuarioRepository.save(usuario)
    }

    fun buscarPorId(nomeUsuario: String): Usuario {
        return usuarioRepository.findById(nomeUsuario)
            .orElseThrow { RuntimeException("Usuário não encontrado") }
    }

    fun listar(): List<Usuario> {
        return usuarioRepository.findAll().toList()
    }

    fun atualizar(nomeUsuario: String, atualizado: Usuario, usuarioLogado: String): Usuario {
        if (nomeUsuario != usuarioLogado) {
            throw RuntimeException("Você não pode alterar outro usuário")
        }

        val existente = buscarPorId(nomeUsuario)

        val novo = existente.copy(
            senha = atualizado.senha,
            fotoPerfil = atualizado.fotoPerfil,
            bio = atualizado.bio
        )

        return usuarioRepository.save(novo)
    }

    fun deletar(nomeUsuario: String, usuarioLogado: String) {
        if (nomeUsuario != usuarioLogado) {
            throw RuntimeException("Você não pode deletar outro usuário")
        }

        usuarioRepository.deleteById(nomeUsuario)
    }
}