import org.springframework.stereotype.Service

@Service
class PostagemService(
    private val postagemRepository: PostagemRepository,
    private val seguidorRepository: SeguidorRepository
) {

    fun criar(postagem: Postagem, usuarioLogado: String): Postagem {
        postagem.usuarioId = usuarioLogado
        postagem.curtidas = 0
        return postagemRepository.save(postagem)
    }

    fun listar(): List<Postagem> {
        return postagemRepository.findAll().toList()
    }

    fun buscarPorId(id: Long): Postagem =
        postagemRepository.findById(id)
            .orElseThrow { RuntimeException("Postagem não encontrada") }

    fun atualizar(id: Long, nova: Postagem, usuarioLogado: String): Postagem {
        val existente = buscarPorId(id)

        if (existente.usuarioId != usuarioLogado) {
            throw RuntimeException("Você não pode editar essa postagem")
        }

        val atualizada = existente.copy(
            foto = nova.foto,
            descricao = nova.descricao
        )

        return postagemRepository.save(atualizada)
    }

    fun deletar(id: Long, usuarioLogado: String) {
        val post = buscarPorId(id)

        if (post.usuarioId != usuarioLogado) {
            throw RuntimeException("Você não pode deletar essa postagem")
        }

        postagemRepository.deleteById(id)
    }

    fun curtir(id: Long) {
        val post = buscarPorId(id)
        post.curtidas++
        postagemRepository.save(post)
    }

    fun descurtir(id: Long) {
        val post = buscarPorId(id)
        if (post.curtidas > 0) {
            post.curtidas--
            postagemRepository.save(post)
        }
    }

    fun postsDeUsuario(usuarioId: String): List<Postagem> {
        return postagemRepository.findByUsuarioIdOrderByIdDesc(usuarioId)
    }

    fun feed(usuarioId: String): List<Postagem> {
        val seguindo = seguidorRepository.findBySeguidorId(usuarioId)
            .map { it.seguidoId }

        if (seguindo.isEmpty()) return emptyList()

        return postagemRepository.findByUsuarioIdInOrderByIdDesc(seguindo)
    }
}