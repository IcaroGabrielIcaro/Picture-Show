# Análise de vulnerabilidades

## A07:2025 - Authentication Failures

Situações em que um atacante consegue enganar o sitema para reconhecer um usuário inválido ou incorreto como legítimo.
-  Possui senhas padrão, fracas ou conhecidas;
-  Possui processos fracos de recuperação de credenciais;
-  Possui autenticação multifator ausente ou ineficaz;
-  Expõe ou reutiliza indicadores de sessão de maneira insegura.

Tela de [login](https://github.com/IcaroGabrielIcaro/Picture-Show/blob/main/frontend-android/picture_show/lib/features/auth/pages/login_page.dart) executa:
```dart
final success = await authProvider.login(
  email: emailController.text.trim(), 
  password: passwordController.text
);
```

[AuthProvider](https://github.com/IcaroGabrielIcaro/Picture-Show/blob/main/frontend-android/picture_show/lib/features/auth/providers/auth_provider.dart) encaminha as credenciais:
```dart
Future<bool> login({required String email, required String password}) async {
    final user = await repository.login(email: email, password: password);
```

[Repository](https://github.com/IcaroGabrielIcaro/Picture-Show/blob/main/frontend-android/picture_show/lib/data/repositories/auth/auth_repository_impl.dart) também encaminha as informações:
```dart
@override
Future<AuthUser?> login({required String email, required String password}) {
  
  return datasource.login(email: email, password: password);
  
}
```

[Datasource](https://github.com/IcaroGabrielIcaro/Picture-Show/blob/main/frontend-android/picture_show/lib/data/datasources/mock/auth_mock_datasource.dart) realiza autenticação no cliente:
```dart
Future<AuthUser?> login({required String email, required String password}) async {
  await Future.delayed(const Duration(microseconds: 500));

  if (email == 'nicolas@pictureshow.com' && password == '123456') {
    return mockUser;
  }
  return null;
}
```

Como a autenticação ocorre no lado do cliente, as informações utilizadas para realizar a autenticação podem estar presentes no próprio aplicativo distribuído ao usuário.

Utilização de senha fixa e conhecida permite que qualquer pessoa que obtenha essa informação seja reconhecida pelo aplicativo como usuário.

### Solução

Envio das credenciais para endpoint de (login)[] do backend:
