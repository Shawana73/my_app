class Validators {
  Validators._();

  static String? requiredText(String? value, String field) {
    if (value == null || value.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[\w\-.]+@[\w\-]+\.[\w\-.]+$').hasMatch(text);
    if (!ok) return 'Enter a valid email address';
    return null;
  }

  static String? phone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Phone is required';
    final ok = RegExp(r'^03\d{9}$').hasMatch(text);
    if (!ok) return 'Use Pakistan format e.g. 03001234567';
    return null;
  }

  static String? cnic(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'CNIC is required';
    final ok = RegExp(r'^\d{5}-\d{7}-\d$').hasMatch(text);
    if (!ok) return 'Use CNIC format xxxxx-xxxxxxx-x';
    return null;
  }

  static String? strongPassword(String? value) {
    final text = value ?? '';
    if (text.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(text)) return 'Add one capital letter';
    if (!RegExp(r'\d').hasMatch(text)) return 'Add one number';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(text)) return 'Add one special character';
    return null;
  }
}
