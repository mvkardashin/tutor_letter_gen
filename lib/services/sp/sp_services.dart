import 'package:shared_preferences/shared_preferences.dart';

abstract class SP {
  static Future<String> getCriterias() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String criterias = prefs.getString('criterias') ?? '';
    return criterias;
  }

  static Future<void> setCriterias(String criterias) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('criterias', criterias);
  }

  // static Future<int> getDecoration() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int decoration = prefs.getInt('decoration') ?? 0;
  //   return decoration;
  // }

  // static Future<void> setDecoration(int decoration) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('decoration', decoration);
  // }

  // static Future<String> getGreeting() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String greeting = prefs.getString('greeting') ?? 'Здравствуйте!';

  //   return greeting;
  // }

  // static Future<void> setGreeting(String greeting) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('greeting', greeting);
  // }

  // static Future<String> getAcceptTeacher() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String acceptteacher =
  //       prefs.getString('acceptteacher') ?? 'Ваша анкета опубликована.';

  //   return acceptteacher;
  // }

  // static Future<void> setAcceptTeacher(String acceptteacher) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('acceptteacher', acceptteacher);
  // }

  // static Future<String> getDeniedTeacher() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String deniedteacher = prefs.getString('deniedteacher') ??
  //       'Ваша анкета возвращена на доработку. Для допуска нужно исправить:';

  //   return deniedteacher;
  // }

  // static Future<void> setDeniedTeacher(String deniedteacher) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('deniedteacher', deniedteacher);
  // }

  // static Future<String> geterrorsHeadline() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String errorsheadline = prefs.getString('errorsheadline') ??
  //       'Причины возврата';

  //   return errorsheadline;
  // }

  // static Future<void> seterrorsHeadline(String deniedteacher) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('deniedteacher', deniedteacher);
  // }

  // static Future<String> geterrorsHeadline() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String errorsheadline = prefs.getString('errorsheadline') ??
  //       'Причины возврата';

  //   return errorsheadline;
  // }

  // static Future<void> seterrorsHeadline(String deniedteacher) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('deniedteacher', deniedteacher);
  // }

  //     this.errorsHeadline = 'Причины возврата',
  //     this.recsHeadline = 'Рекомендации',
  //     this.endText =
  //         'Пожалуйста, не забудьте, после внесения изменений, отправить анкету на проверку.',
  //     this.withRespect = 'С уважением, администратор Сервиса.',
}
