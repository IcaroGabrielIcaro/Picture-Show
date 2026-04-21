import org.springframework.security.core.Authentication
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.oauth2.jwt.JwtClaimsSet
import org.springframework.security.oauth2.jwt.JwtEncoder
import org.springframework.security.oauth2.jwt.JwtEncoderParameters
import org.springframework.stereotype.Service
import java.time.Instant

@Service
class JwtService (
    private val encoder: JwtEncoder
) {

    fun gerarToken(autenticacao: Authentication): String {

        val now = Instant.now()
        val expiry = 3600L

        val scopes = autenticacao.authorities
            .map(GrantedAuthority::getAuthority)
            .joinToString(" ")

        val claims = JwtClaimsSet.builder()
            .issuer("spring-security-jwt")
            .issuedAt(now)
            .expiresAt(now.plusSeconds(expiry))
            .subject(autenticacao.name)
            .claim("scope", scopes)
            .build()

        return encoder
            .encode(JwtEncoderParameters.from(claims))
            .tokenValue
    }
}