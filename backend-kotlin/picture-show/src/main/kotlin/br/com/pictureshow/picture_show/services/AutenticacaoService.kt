import org.springframework.stereotype.Service
import org.springframework.security.core.Authentication

@Service
class AutenticacaoService (
    private val jwtService: JwtService
) {

    fun autenticar(autenticacao: Authentication): String {
        return jwtService.gerarToken(autenticacao)
    }
}