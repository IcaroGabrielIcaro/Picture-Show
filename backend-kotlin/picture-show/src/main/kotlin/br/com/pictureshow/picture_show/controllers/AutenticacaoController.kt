import io.swagger.v3.oas.annotations.tags.Tag
import io.swagger.v3.oas.annotations.Operation
import org.springframework.web.bind.annotation.*
import org.springframework.security.core.Authentication

@Tag(name = "Autenticacao", description = "Autenticacao")
@RestController
class AutenticacaoController(
    private val autenticacaoService: AutenticacaoService
) {
   
    @Operation(summary = "Autenticar", description = "Autentica")
    @PostMapping("autenticacao")
    fun autenticar(autenticacao: Authentication): String {
        return autenticacaoService.autenticar(autenticacao)
    }
}