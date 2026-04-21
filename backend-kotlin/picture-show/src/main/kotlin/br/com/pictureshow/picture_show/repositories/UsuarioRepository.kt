import org.springframework.data.repository.CrudRepository

interface UsuarioRepository : CrudRepository<Usuario, String> {

    fun findByNomeUsuario(nomeUsuario: String): Usuario?
    fun existsByNomeUsuario(nomeUsuario: String): Boolean

}