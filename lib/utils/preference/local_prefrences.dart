
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:otp_demooo/model/jwt_token_response_model/jwt_token_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUtils {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();
  static JwtTokeResponseModel get tokenResponseModel => userData();

  static Future<void> saveUserDetails(String token) async {
    await instance.setString('token', token);
  }

  static Future<String?> fetchToken() async {
    final token = instance.getString('token') ?? '';
    if (token.isEmpty) {
      return "";
    }
    return token;
  }

  static JwtTokeResponseModel userData() {
    final token = instance.getString('token') ?? '';
    var userData = JwtDecoder.decode(token);
    var userDecoded = JwtTokeResponseModel.fromJson(userData);
    return userDecoded;
  }

  static Future<void> clear() async {
    await instance.clear();
  }

  static Future<void> savePhoneNumber(String number) async {
    await instance.setString('phoneNumber', number);
  }

  static Future<String?> fetchPhoneNumber() async {
    final number = instance.getString('phoneNumber') ?? "";
    if (number.isEmpty) {
      return "";
    }
    return number;
  }
}
