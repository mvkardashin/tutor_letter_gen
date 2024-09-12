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

  static Future<String> getEmailAnswers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String criterias = prefs.getString('emails') ?? '';
    return criterias;
  }

  static Future<void> setEmailAnswers(String answers) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emails', answers);
  }
}
