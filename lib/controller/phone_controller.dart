import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_demooo/utils/api/api_base.dart';


class SendOtpController extends GetxController {
  final TextEditingController _phoneController = TextEditingController();
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  final ApiBase apiBase = ApiBase();
  final _isEndOtpError = ''.obs;
  String get isEndOtpError => _isEndOtpError.value;
  TextEditingController get phoneController => _phoneController;

  Future<void> sendOtp(
      {required String phoneNumber,
      required int? groupId,
      required BuildContext context,
      Function()? onSuccess}) async {
    _isLoading(true);

    final parameters = {
      "phoneNumber": phoneNumber,
      "groupId": 1703228300417,
    };
    await apiBase.post(
        'https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com/authgw/sendotp',
        parameters, (data) {
      _isLoading(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Otp Send SuccesFully")));
      onSuccess!.call();
    }, (error) {
      _isLoading(false);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("error")));
    });
  }

  clearData() {
    _phoneController.clear();
  }
}
