/// Representa um usuário da aplicação.
class Usuario {
  /// Identificador único.
  final int id;

  /// Nome de usuário único utilizado para login.
  final String username;

  /// Nome exibido para os demais usuários.
  final String nome;

  /// Biografia do perfil.
  final String bio;

  /// URL da foto de perfil.
  ///
  /// Pode ser nula caso o usuário ainda não tenha cadastrado uma imagem.
  final String? imagem;

  /// Quantidade de seguidores.
  final int seguidores;

  /// Quantidade de usuários seguidos.
  final int seguindo;

  /// Quantidade de publicações.
  final int publicacoes;

  /// Indica se o usuário autenticado segue este perfil.
  final bool euSigo;

  const Usuario({
    required this.id,
    required this.username,
    required this.nome,
    required this.bio,
    this.imagem,
    required this.seguidores,
    required this.seguindo,
    required this.publicacoes,
    required this.euSigo,
  });

  /// Cria uma instância a partir do JSON retornado pela API.
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      username: json['username'] as String,
      nome: json['nome'] as String,
      bio: json['bio'] as String? ?? '',
      imagem: json['imagem'] as String?,
      seguidores: json['seguidores'] as int? ?? 0,
      seguindo: json['seguindo'] as int? ?? 0,
      publicacoes: json['publicacoes'] as int? ?? 0,
      euSigo: json['eu_sigo'] as bool? ?? false,
    );
  }

  /// Converte a instância para JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'nome': nome,
      'bio': bio,
      'imagem': imagem,
      'seguidores': seguidores,
      'seguindo': seguindo,
      'publicacoes': publicacoes,
      'eu_sigo': euSigo,
    };
  }

  /// Cria uma cópia alterando apenas os campos desejados.
  Usuario copyWith({
    int? id,
    String? username,
    String? nome,
    String? bio,
    String? imagem,
    int? seguidores,
    int? seguindo,
    int? publicacoes,
    bool? euSigo,
  }) {
    return Usuario(
      id: id ?? this.id,
      username: username ?? this.username,
      nome: nome ?? this.nome,
      bio: bio ?? this.bio,
      imagem: imagem ?? this.imagem,
      seguidores: seguidores ?? this.seguidores,
      seguindo: seguindo ?? this.seguindo,
      publicacoes: publicacoes ?? this.publicacoes,
      euSigo: euSigo ?? this.euSigo,
    );
  }

  @override
  String toString() {
    return 'Usuario(id: $id, username: $username, nome: $nome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Usuario &&
        other.id == id &&
        other.username == username &&
        other.nome == nome &&
        other.bio == bio &&
        other.imagem == imagem &&
        other.seguidores == seguidores &&
        other.seguindo == seguindo &&
        other.publicacoes == publicacoes &&
        other.euSigo == euSigo;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      username,
      nome,
      bio,
      imagem,
      seguidores,
      seguindo,
      publicacoes,
      euSigo,
    );
  }
}
