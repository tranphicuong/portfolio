class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String resume = '/resume';
  static const String skills = '/skills';
  static const String projects = '/projects';
  static const String contact = '/contact';
}

//Cac hieu ung chuyen trang
class Breakpoints {
  Breakpoints._();

  //Mobile
  static const double mobile = 600;

  //Tablet
  static const double tablet = 1024;

  //Desktop
  static const double desktop = 1440;
  //Chuyen doi sang giao dien nho hon 760px 
  static const double compactNav = 760;

  //chieu rong toi da cua noi dung chinh
  static const double maxContentWidth = 1100;
}

//Hieu ung chuyen trang
class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration pageTransition = Duration(milliseconds: 450);
}

//Quy tac validate cac input trong form
class AppValidation {
  AppValidation._();

  static const int minNameLength = 2;
  static const int minMessageLength = 20;
}

//cau hinh emailjs
class EmailJsConfig {
  EmailJsConfig._();

  static const String serviceId = 'service_se0mcy9';
  static const String templateId = 'template_4d64vun';
  static const String publicKey = 'nZ0C_t5aHIrfk48H9';
}