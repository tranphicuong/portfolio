import 'constants.dart';

//Cac ham kiem tra du lieu nhap cua nguoi dung
class Validators {
  Validators._();
  //Regex kiem tra email
  static final RegExp _emailRegex =
      RegExp(r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$');
  //Kiem tra rong, kiem tra do dai cua ten
  static String? name(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Vui lòng nhập họ tên';
    if (text.length < AppValidation.minNameLength) {
      return 'Họ tên phải có ít nhất ${AppValidation.minNameLength} ký tự';
    }
    return null;
  }
  //kiem tra rong, kiem tra do dai cua email, kiem tra dinh dang email
  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Vui lòng nhập email';
    if (!_emailRegex.hasMatch(text)) {
      return 'Email không đúng định dạng (ví dụ: ten@gmail.com)';
    }
    return null;
  }
  //Kiem tra rong, kiem tra do dai cua noi dung tin nhan
  static String? message(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Vui lòng nhập nội dung tin nhắn';
    if (text.length < AppValidation.minMessageLength) {
      return 'Nội dung tối thiểu ${AppValidation.minMessageLength} ký tự '
          '(hiện có ${text.length})';
    }
    return null;
  }
}
