import io.swagger.v3.oas.annotations.tags.Tag
import io.swagger.v3.oas.annotations.Operation
import org.springframework.web.bind.annotation.*
import org.springframework.security.core.Authentication

@Tag(name = "Postagens", description = "Gerencia de postagens")
@RestController
@RequestMapping("/postagens")
class PostagemController(
    private val postagemService: PostagemService
) {

    @Operation(summary = "Listar feed", description = "Retorna o feed do usuário autenticado")
    @GetMapping
    fun listarPostagens(authentication: Authentication): List<Postagem> {
        return postagemService.feed(authentication.name)
    }

    @Operation(summary = "Listar postagens de um usuário", description = "Retorna todas as postagens de um usuário específico")
    @GetMapping("/usuario/{usuarioId}")
    fun listarPorUsuario(@PathVariable usuarioId: String): List<Postagem> {
        return postagemService.postsDeUsuario(usuarioId)
    }

    @Operation(summary = "Buscar postagem", description = "Retorna uma postagem pelo ID")
    @GetMapping("/{id}")
    fun buscar(@PathVariable id: Long): Postagem {
        return postagemService.buscarPorId(id)
    }

    @Operation(summary = "Criar postagem", description = "Cria uma nova postagem")
    @PostMapping
    fun criar(
        @RequestBody postagem: Postagem,
        authentication: Authentication
    ): Postagem {
        return postagemService.criar(postagem, authentication.name)
    }

    @Operation(summary = "Atualizar postagem", description = "Atualiza uma postagem do usuário")
    @PutMapping("/{id}")
    fun atualizar(
        @PathVariable id: Long,
        @RequestBody postagem: Postagem,
        authentication: Authentication
    ): Postagem {
        return postagemService.atualizar(id, postagem, authentication.name)
    }

    @Operation(summary = "Deletar postagem", description = "Remove uma postagem do usuário")
    @DeleteMapping("/{id}")
    fun deletar(
        @PathVariable id: Long,
        authentication: Authentication
    ) {
        postagemService.deletar(id, authentication.name)
    }

    @Operation(summary = "Curtir postagem", description = "Adiciona uma curtida na postagem")
    @PostMapping("/{id}/curtir")
    fun curtir(@PathVariable id: Long) {
        postagemService.curtir(id)
    }

    @Operation(summary = "Descurtir postagem", description = "Remove uma curtida da postagem")
    @PostMapping("/{id}/descurtir")
    fun descurtir(@PathVariable id: Long) {
        postagemService.descurtir(id)
    }
}