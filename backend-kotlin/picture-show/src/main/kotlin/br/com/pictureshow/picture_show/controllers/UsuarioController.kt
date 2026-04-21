import io.swagger.v3.oas.annotations.Operation
import io.swagger.v3.oas.annotations.tags.Tag
import org.springframework.security.core.Authentication
import org.springframework.web.bind.annotation.*

@Tag(name = "Usuarios", description = "Gerencia de usuários")
@RestController
@RequestMapping("/usuarios")
class UsuarioController(private val usuarioService: UsuarioService) {

    @Operation(summary = "Criar usuário", description = "Cria um novo usuário")
    @PostMapping
    fun criar(@RequestBody usuario: Usuario): Usuario {
        return usuarioService.criar(usuario)
    }

    @Operation(summary = "Buscar usuário", description = "Retorna um usuário pelo nome")
    @GetMapping("/{nomeUsuario}")
    fun buscar(@PathVariable nomeUsuario: String): Usuario {
        return usuarioService.buscarPorId(nomeUsuario)
    }

    @Operation(summary = "Listar usuários", description = "Lista todos os usuários")
    @GetMapping
    fun listar(): List<Usuario> {
        return usuarioService.listar()
    }

    @Operation(summary = "Atualizar usuário", description = "Atualiza os dados do usuário autenticado")
    @PutMapping("/{nomeUsuario}")
    fun atualizar(
            @PathVariable nomeUsuario: String,
            @RequestBody usuario: Usuario,
            authentication: Authentication
    ): Usuario {
        return usuarioService.atualizar(nomeUsuario, usuario, authentication.name)
    }

    @Operation(summary = "Deletar usuário", description = "Remove o usuário autenticado")
    @DeleteMapping("/{nomeUsuario}")
    fun deletar(@PathVariable nomeUsuario: String, authentication: Authentication) {
        usuarioService.deletar(nomeUsuario, authentication.name)
    }
}
