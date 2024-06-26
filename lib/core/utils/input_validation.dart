class InputValidation {
  static String? email(String email) {
    // Regular expression for basic email validation
    final RegExp regex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!regex.hasMatch(email)) {
      return 'Invalid email format.';
    }

    return null; // Return null if valid
  }

  static String? phone(String phoneNumber) {
    // Regular expression for basic phone number validation
    final RegExp regex = RegExp(r'^[0-9]{10}$'); // Matches 10 digits

    if (!regex.hasMatch(phoneNumber)) {
      return 'Invalid phone number format.';
    }

    return null; // Return null if valid
  }

  static String? minLength(String value, int length) {
    if (value.length < length) {
      return 'Length must be greater than or equal to 6.';
    }
    return null; // Return null if valid
  }

  static String? numbers(String value) {
    // Regular expression for matching only numeric characters
    final RegExp regex = RegExp(r'^[0-9]+$'); // Matches one or more digits

    if (!regex.hasMatch(value)) {
      return 'Only numbers are valid for this field.';
    }

    return null; // Return null if the string contains only numbers
  }
}
