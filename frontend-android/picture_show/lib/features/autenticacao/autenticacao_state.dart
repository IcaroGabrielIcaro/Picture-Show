enum AutenticacaoStatus { idle, loading, success, error }

class AutenticacaoState {
  final AutenticacaoStatus status;
  final String? message;

  const AutenticacaoState({
    this.status = AutenticacaoStatus.idle,
    this.message,
  });

  AutenticacaoState copyWith({AutenticacaoStatus? status, String? message}) {
    return AutenticacaoState(status: status ?? this.status, message: message);
  }
}
