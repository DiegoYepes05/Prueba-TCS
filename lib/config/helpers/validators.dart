/// A utility class containing static validator functions for form fields.
class Validators {
  /// Validates if the given [value] is empty.
  /// Returns an error message if empty, otherwise null.
  static String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  /// Validates if the given [value] is a valid email address.
  /// Returns an error message if invalid, otherwise null.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingresa un correo electrónico válido';
    }
    return null;
  }

  /// Validates if the given [value] is a valid password.
  /// Requires at least 8 characters.
  /// Returns an error message if invalid, otherwise null.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }

  /// Validates if the given [value] is a valid password confirmation.
  /// Requires at least 8 characters and matches the original password.
  /// Returns an error message if invalid, otherwise null.
  static String? validatePasswordConfirmation({
    required String value,
    required String originalPassword,
  }) {
    if (value.isEmpty) {
      return 'Por favor confirma tu contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (value != originalPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  /// Validates if the given [value] is a valid name (letters and spaces only).
  /// Returns an error message if invalid, otherwise null.
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu nombre';
    }
    final RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Por favor ingresa un nombre válido';
    }
    return null;
  }
}
