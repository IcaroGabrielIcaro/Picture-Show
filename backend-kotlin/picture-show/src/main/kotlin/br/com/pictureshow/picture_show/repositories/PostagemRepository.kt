import org.springframework.data.repository.CrudRepository

interface PostagemRepository : CrudRepository<Postagem, Long> {

    fun findByUsuarioIdOrderByIdDesc(usuarioId: String): List<Postagem>
    fun findByUsuarioIdInOrderByIdDesc(usuarios: List<String>): List<Postagem>
    fun countByUsuarioId(usuarioId: String): Long
    
}