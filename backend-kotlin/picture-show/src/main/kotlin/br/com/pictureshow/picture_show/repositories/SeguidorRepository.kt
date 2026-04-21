import org.springframework.data.repository.CrudRepository

interface SeguidorRepository : CrudRepository<Seguidor, Long> {

    fun findBySeguidoId(seguidoId: String): List<Seguidor>
    fun findBySeguidorId(seguidorId: String): List<Seguidor>
    fun existsBySeguidorIdAndSeguidoId(seguidorId: String, seguidoId: String): Boolean
    fun deleteBySeguidorIdAndSeguidoId(seguidorId: String, seguidoId: String)
    fun countBySeguidoId(seguidoId: String): Long
    fun countBySeguidorId(seguidorId: String): Long
    
}