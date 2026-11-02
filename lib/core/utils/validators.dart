class Validators {
  Validators._();

  static String? notEmpty(String? v, [String field = 'This field']) =>
      (v == null || v.trim().isEmpty) ? '$field is required' : null;

  static String? email(String? v) {
    final empty = notEmpty(v, 'Email');
    if (empty != null) return empty;
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v!.trim());
    return ok ? null : 'Enter a valid email address';
  }

  static String? password(String? v) {
    final empty = notEmpty(v, 'Password');
    if (empty != null) return empty;
    return v!.length < 6 ? 'Minimum 6 characters' : null;
  }

  static String? mobile(String? v) {
    final empty = notEmpty(v, 'Mobile number');
    if (empty != null) return empty;
    return RegExp(r'^\d{10}$').hasMatch(v!.trim())
        ? null
        : 'Enter a valid 10 digit number';
  }
}
