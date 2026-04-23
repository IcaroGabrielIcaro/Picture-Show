# Picture-Show

Aplicação de rede social simples desenvolvida como atividade acadêmica, permitindo que usuários realizem postagens, curtam conteúdos e sigam outros usuários.

## Funcionalidades

- Criar postagens
- Curtir publicações
- Seguir outros usuários
- Visualizar feed
- Notificações (estrutura inicial)

## Protótipo

Protótipos das telas desenvolvidos no Figma, incluindo:

- Feed
- Perfil
- Notificações

## Frontend

Aplicação mobile desenvolvida com:

- Flutter
- Dart

### Arquitetura

O projeto segue uma estrutura simples baseada em separação de responsabilidades:

```cmd
lib/
    core/  
    features/
```

### Recursos utilizados

- Consumo de API REST
- Persistência local de dados (cache simples no dispositivo)

## Backend

API desenvolvida com:

- Django
- Django REST Framework

### Endpoints principais

- `/posts/` → Listagem e criação de postagens  
- `/users/` → Usuários  
- `/likes/` → Curtidas  
- `/followers/` → Seguidores  

> A API é responsável pelo armazenamento principal dos dados e regras de negócio.

## Persistência de Dados

A aplicação utiliza duas fontes de dados:

- **Remota (API)** → dados principais
- **Local (dispositivo)** → cache de dados para acesso offline

A persistência local é utilizada para:

- Armazenar dados do feed
- Melhorar desempenho
- Permitir funcionamento básico sem conexão