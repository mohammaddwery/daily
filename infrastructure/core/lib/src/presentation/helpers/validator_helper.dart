
class _ValidatorHelper {
  static bool isNullOrEmpty(String? input) => input?.isEmpty??true;
  static bool isPhoneNumber(String input) => RegExp(
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
  ).hasMatch(input);
  static bool isLengthValid(String input, int start, int end) =>
      input.length >= start && input.length <= end;
}

extension StringValidationExtension on String? {
  bool get isNullOrEmpty => _ValidatorHelper.isNullOrEmpty(this);
  bool get isPhoneNumber => _ValidatorHelper.isPhoneNumber(this??'');
  bool isLengthValid(int start, int end) => _ValidatorHelper.isLengthValid(this??'', start, end);
}