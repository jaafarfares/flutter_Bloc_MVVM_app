class Validators {
  static String? required(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^\S+@\S+.\S+$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }
}
