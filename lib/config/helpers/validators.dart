// lib/config/helpers/validators.dart

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

  // -----------------------------
  // VALIDACIONES PARA REPORTES
  // -----------------------------

  /// Valida el título (obligatorio, mínimo 3 caracteres)
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'El título es obligatorio';
    }
    if (value.length < 3) {
      return 'El título debe tener al menos 3 caracteres';
    }
    return null;
  }

  /// Valida la descripción (opcional, pero con máximo 200 caracteres)
  static String? validateDescription(String? value) {
    if (value != null && value.length > 200) {
      return 'La descripción no puede superar los 200 caracteres';
    }
    return null;
  }

  /// Valida el monto (obligatorio, número positivo)
  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'El monto es obligatorio';
    }
    final double? amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Ingresa un monto válido mayor a 0';
    }
    return null;
  }

  /// Valida la fecha (obligatoria)
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'La fecha es obligatoria';
    }
    return null;
  }

  /// Valida la categoría (obligatoria)
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'La categoría es obligatoria';
    }
    return null;
  }
}
