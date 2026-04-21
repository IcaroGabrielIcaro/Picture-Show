import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException

class DetalheUsuarioService (
    private val usuarioRepository: UsuarioRepository
) : UserDetailsService {

    override fun loadUserByUsername(nomeusuario: String): UserDetails {
        val usuario = usuarioRepository.findByNomeUsuario(nomeusuario)
            ?: throw UsernameNotFoundException("Usuario não encontrado")

        return UsuarioAutenticado(usuario)
    }

}