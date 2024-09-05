class FieldValidation {
  static FieldValidation? _instance;

  FieldValidation._();

  static FieldValidation get instance {
    return _instance ??= FieldValidation._();
  }

  String? validateEmail(String? data) {
    if (data == null || !data.contains("@") || data.isEmpty) {
      return 'Digite um email válido';
    }
    return null;
  }

  String? validateName(String? data) {
    if (data == null || data.isEmpty) return 'Nome inválido';
    return null;
  }

  String? commonField(String? data) {
    if (data == null || data.isEmpty) return 'Campo inválido';
    return null;
  }

  String? validatePass(String? data) {
    if (data == null || data.isEmpty) {
      return 'Senha inválida';
    } else if (data.length < 5) {
      return 'Senha muito curta';
    }
    return null;
  }

  String? validatePassConfirmation({
    required String? data,
    required String firstPass,
  }) {
    if (data == null || data.isEmpty) {
      return 'Senha inválida';
    } else if (data.length < 8) {
      return 'Senha muito curta';
    } else if (data != firstPass) {
      return 'Senhas diferentes';
    }
    return null;
  }
}
