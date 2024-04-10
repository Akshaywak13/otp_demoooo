import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_demooo/utils/api/api_base.dart';
import 'package:otp_demooo/utils/preference/local_prefrences.dart';

class RefreshTokenController extends GetxController{

ApiBase _apiBase=ApiBase();

  final isLoading=false.obs;
  bool get _isLoading=>isLoading.value;
  
  final _isEndOtpError = ''.obs;
  String get isEndOtpError => _isEndOtpError.value;

  Future<void> refreshToken({required BuildContext context , required String groupId})async{
    String? token = await LocalStorageUtils.fetchToken();

    await _apiBase.post("https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com/authgw/refresh-token",
    {"token": token,
    "groupId":groupId
    },
     (data) {
      if(data['token'] != null){
        _isEndOtpError.value='';
        LocalStorageUtils.saveUserDetails(data['token']);


      }else{
        _isEndOtpError.value='Please contect to Administrator';
        isLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isEndOtpError.value)));
      }
     }, (error) {
      isLoading(false);
      _isEndOtpError.value = error;
     });

    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    refresh();
  }
}