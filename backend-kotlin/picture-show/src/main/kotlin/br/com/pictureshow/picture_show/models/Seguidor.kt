import org.springframework.data.relational.core.mapping.Table

@Table("seguidores")
data class Seguidor(

    val seguidorId: String,
    val seguidoId: String

)