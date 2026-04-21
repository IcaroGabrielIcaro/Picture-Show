CREATE TABLE IF NOT EXISTS usuarios (
    nome_usuario VARCHAR(100) PRIMARY KEY,
    senha VARCHAR(255) NOT NULL,
    foto_perfil TEXT,
    bio TEXT
);

CREATE TABLE IF NOT EXISTS postagens (
    id BIGSERIAL PRIMARY KEY,

    foto TEXT NOT NULL,
    descricao TEXT,
    curtidas INT DEFAULT 0,

    usuario_id VARCHAR(100) NOT NULL,

    CONSTRAINT fk_post_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(nome_usuario)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS seguidores (
    seguidor_id VARCHAR(100) NOT NULL,
    seguido_id VARCHAR(100) NOT NULL,

    PRIMARY KEY (seguidor_id, seguido_id),

    CONSTRAINT fk_seguidor_usuario
        FOREIGN KEY (seguidor_id)
        REFERENCES usuarios(nome_usuario)
        ON DELETE CASCADE,

    CONSTRAINT fk_seguido_usuario
        FOREIGN KEY (seguido_id)
        REFERENCES usuarios(nome_usuario)
        ON DELETE CASCADE
);