import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.*

@Tag(name = "Seguidores", description = "Gerencia seguidores")
@RestController
@RequestMapping("/seguidores")
class SeguidorController(private val seguidorService: SeguidorService) {

    @Operation(summary = "Seguir usuário", description = "Usuário autenticado começa a seguir outro usuário")
    @PostMapping("/{usuario}")
    fun seguir(@PathVariable usuario: String, authentication: Authentication) {
        seguidorService.seguir(authentication.name, usuario, authentication.name)
    }

    @Operation(summary = "Deixar de seguir", description = "Usuário autenticado deixa de seguir outro usuário")
    @DeleteMapping("/{usuario}")
    fun deixarDeSeguir(@PathVariable usuario: String, authentication: Authentication) {
        seguidorService.deixarDeSeguir(authentication.name, usuario, authentication.name)
    }

    @Operation(summary = "Listar seguidores", description = "Lista quem segue um usuário")
    @GetMapping("/{usuario}/seguidores")
    fun listarSeguidores(@PathVariable usuario: String): List<String> {
        return seguidorService.listarSeguidores(usuario)
    }

    @Operation(summary = "Listar seguindo", description = "Lista quem o usuário segue")
    @GetMapping("/{usuario}/seguindo")
    fun listarSeguindo(@PathVariable usuario: String): List<String> {
        return seguidorService.listarSeguindo(usuario)
    }

    @Operation(summary = "Contar seguidores", description = "Quantidade de seguidores de um usuário")
    @GetMapping("/{usuario}/seguidores/count")
    fun contarSeguidores(@PathVariable usuario: String): Long {
        return seguidorService.contarSeguidores(usuario)
    }

    @Operation(summary = "Contar seguindo", description = "Quantidade de usuários que ele segue")
    @GetMapping("/{usuario}/seguindo/count")
    fun contarSeguindo(@PathVariable usuario: String): Long {
        return seguidorService.contarSeguindo(usuario)
    }
}
