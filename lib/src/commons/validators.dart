class Validators {
  fullNameValidator(String value) {
    RegExp nameExp = RegExp(
        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
        caseSensitive: false);
    // ignore: unnecessary_null_comparison
    if (value.isNotEmpty && value.trim().length < 8) {
      return 'El nombre debe tener al menos 8 caracteres';
    } else if (!nameExp.hasMatch(value)) {
      return 'Ingrese un nombre válido que contenga letras, y espacios';
    }
    return null;
  }

  userNameValidator(String value) {
    RegExp nameExp = RegExp(
        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$",
        caseSensitive: false);
    if (value.isEmpty) {
      return "Debe llenar este campo";
    } else if (!nameExp.hasMatch(value)) {
      return 'Ingrese un nombre válido que contenga letras, y espacios';
    }
    return null;
  }

  emailValidator(String value) {
    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        caseSensitive: false);
    if (value.isEmpty) return "Debe llenar este campo";
    if (!emailExp.hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  emailLoginValidator(String value) {
    RegExp emailLoginExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        caseSensitive: false);
    if (value.isEmpty) return "Introduzca su correo en este campo";
    if (!emailLoginExp.hasMatch(value)) {
      return 'Escriba un correo electrónico válido';
    }
    return null;
  }

  emptyFieldValidator(String value) {
    if (value.isEmpty) return "Rellene este campo";
    return null;
  }

  phoneValidator(String value) {
    RegExp phoneExp = RegExp(r"^\+([0-9]{1,4})\s?([0-9]{6,15})$");
    if (value.isEmpty) return "Debe ingresar un número de teléfono";
    if (!phoneExp.hasMatch(value)) {
      return "Ingrese un número de teléfono válido";
    } else if (value.contains("+591") &&
        (value.length > 12 || value.length < 12)) {
      return "Ingrese un número de teléfono válido";
    }
    return null;
  }

  emptyInputPin(String? value) {
    if (value == null) return "";
    if (value.isEmpty) return "";
    return null;
  }

  nitCIinputValidator(String? value) {
    final RegExp numericRegex = RegExp(r'^\d+$');
    if (value!.isEmpty) {
      return 'Este campo no puede estar vacío';
    }
    if (!numericRegex.hasMatch(value)) {
      return 'Este campo solo puede contener números';
    }
    return null;
  }

  invoiceNameInputValidator(String? value) {
    final RegExp regex = RegExp(r'^[a-zA-Z]+$');
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    if (!regex.hasMatch(value)) {
      return 'Ingrese un nombre valido para la factura';
    }

    return null;
  }

  /* passValidator(String value) {
    RegExp passExp = RegExp(r"^(?=.*[A-Z])(?=.*[0-9])(?=.{8,})");
    if (value.isEmpty) return "Debe rellenar este campo";
    if (!passExp.hasMatch(value)) {
      return "La contraseña debe tener al menos 8 caracteres, una mayúscula y un número";
    }
  } */

  passValidator(String value) {
    if (value.isEmpty) return "Debe rellenar este campo";
    if (value.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    }
    return null;
  }
}
