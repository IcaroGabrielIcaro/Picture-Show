import org.springframework.data.relational.core.mapping.Table
import org.springframework.data.annotation.Id

@Table("usuarios")
data class Usuario(

    @Id
    var nomeUsuario: String,
    var senha: String,
    var fotoPerfil: String,
    var bio: String

)