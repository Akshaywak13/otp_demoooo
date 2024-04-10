import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_demooo/controller/refresh_token/refresh_token.dart';
import 'package:otp_demooo/utils/api/api_base.dart';
import 'package:otp_demooo/utils/preference/local_prefrences.dart';
import 'package:otp_demooo/view/home_screen.dart';

class VerifyController extends GetxController {
  final ApiBase apiBase = ApiBase();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final _isEndOtpError = ''.obs;
  String get isEndOtpError => _isEndOtpError.value;
  TextEditingController get phoneController => _numberController;
  TextEditingController get otpController => _otpController;

  final RefreshTokenController _refreshTokenController =
  Get.put(RefreshTokenController());
     // Get.find<RefreshTokenController>();

  Future<void> verifyOtp({
    required BuildContext context,
    required String number,
    required int otp,
  }) async {
    var payload = {"phoneNumber": number, "otp": otp};
    _isLoading(true);
    await apiBase.post(
        'https://4r4iwhot12.execute-api.ap-south-1.amazonaws.com/auth/auth/validateOtp/',
        payload, (data) {
      _isLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Success"),
        backgroundColor: Colors.green,
      ));
      if (data["data"]["userExists"] == true)
      // ignore: curly_braces_in_flow_control_structures
      if (data["data"]["userExists"] == true)
       {
        LocalStorageUtils.saveUserDetails(data['token']);
        _refreshTokenController.refreshToken(context: context, groupId: "1703228300417");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        _isEndOtpError.value = 'please Enter valid phone number';
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please check the Otp number"),
          backgroundColor: Colors.red,
        ));
      }
    }, (error) {
      _isLoading(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error")));
      _isEndOtpError.value = error;
    });
  }

  clearData() {
    _otpController.clear();

    refresh();
  }
}
