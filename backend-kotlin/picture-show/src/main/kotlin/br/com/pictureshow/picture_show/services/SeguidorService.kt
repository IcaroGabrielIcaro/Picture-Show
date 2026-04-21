import org.springframework.stereotype.Service

@Service
class SeguidorService(
    private val seguidorRepository: SeguidorRepository,
    private val usuarioRepository: UsuarioRepository
) {

    fun seguir(seguidor: String, seguido: String, usuarioLogado: String) {
        if (seguidor != usuarioLogado) {
            throw RuntimeException("Você não pode seguir por outro usuário")
        }

        if (seguidor == seguido) {
            throw RuntimeException("Não pode seguir a si mesmo")
        }

        if (!usuarioRepository.existsByNomeUsuario(seguido)) {
            throw RuntimeException("Usuário não existe")
        }

        if (!seguidorRepository.existsBySeguidorIdAndSeguidoId(seguidor, seguido)) {
            seguidorRepository.save(Seguidor(seguidor, seguido))
        }
    }

    fun deixarDeSeguir(seguidor: String, seguido: String, usuarioLogado: String) {
        if (seguidor != usuarioLogado) {
            throw RuntimeException("Você não pode executar essa ação")
        }

        seguidorRepository.deleteBySeguidorIdAndSeguidoId(seguidor, seguido)
    }

    fun listarSeguidores(usuario: String): List<String> {
        return seguidorRepository.findBySeguidoId(usuario).map { it.seguidorId }
    }

    fun listarSeguindo(usuario: String): List<String> {
        return seguidorRepository.findBySeguidorId(usuario).map { it.seguidoId }
    }

    fun contarSeguidores(usuario: String): Long {
        return seguidorRepository.countBySeguidoId(usuario)
    }

    fun contarSeguindo(usuario: String): Long {
        return seguidorRepository.countBySeguidorId(usuario)
    }
}
