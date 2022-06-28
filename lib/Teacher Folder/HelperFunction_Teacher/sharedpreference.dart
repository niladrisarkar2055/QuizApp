import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions
{
  static String TeachersharedPreferenceUserLoggedInKey = "Teacher_ISLOGGEDIN";
  static String TeachersharedPreferenceUserNameKey = "Teacher_USERNAMEKEY";
  static String TeachersharedPreferenceUserEmailKey = "Teacher_USEREMAILKEY";

  /// saving data to sharedpreference
  static Future<bool> Teacher_saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(TeachersharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }
  
  static Future<bool> Teacher_saveUserNameSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(TeachersharedPreferenceUserNameKey, userName);
  }
  static Future<bool> Teacher_saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(TeachersharedPreferenceUserEmailKey, userEmail);
  }
  
  /// fetching data from sharedpreference
  static Future<bool?> Teacher_getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(TeachersharedPreferenceUserLoggedInKey);
  }
  
  /// fetching data from sharedpreference
  static Future<String?> Teacher_getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(TeachersharedPreferenceUserNameKey);
  }
  
  /// fetching data from sharedpreference
  static Future<String?> Teacher_getUserEmailSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(TeachersharedPreferenceUserEmailKey);
  }
}