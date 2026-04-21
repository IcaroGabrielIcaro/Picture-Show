import org.springframework.data.relational.core.mapping.Table
import org.springframework.data.annotation.Id

@Table("postagens")
data class Postagem(

    @Id
    var id: Long? = null,
    var foto: String,
    var descricao: String,
    var curtidas: Int,
    
    var usuarioId: String

)