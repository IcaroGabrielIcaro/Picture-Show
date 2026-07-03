class UsuarioResumo {
  final int id;
  final String username;
  final String nome;
  final String? imagem;

  UsuarioResumo({
    required this.id,
    required this.username,
    required this.nome,
    this.imagem,
  });

  factory UsuarioResumo.fromJson(Map<String, dynamic> json) {
    return UsuarioResumo(
      id: json['id'] as int,
      username: json['username'] as String,
      nome: json['nome'] as String,
      imagem: json['imagem'] as String?,
    );
  }

  factory UsuarioResumo.fromDatabase(Map<String, dynamic> map) {
    return UsuarioResumo(
      id: map['autor_id'] as int,
      username: map['autor_username'] as String,
      nome: map['autor_nome'] as String,
      imagem: map['autor_imagem'] as String?,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'autor_id': id,
      'autor_username': username,
      'autor_nome': nome,
      'autor_imagem': imagem,
    };
  }

  @override
  String toString() {
    return 'UsuarioResumo('
        'id: $id, '
        'username: $username, '
        'nome: $nome, '
        'imagem: $imagem'
        ')';
  }
}
