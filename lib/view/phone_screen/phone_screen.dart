

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_demooo/controller/phone_controller.dart';
import 'package:otp_demooo/view/verify_otp/verify_otp.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

final SendOtpController sendOtpController = Get.put(SendOtpController());
final _formKey = GlobalKey<FormState>();

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: const Text("Send Otp")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: sendOtpController.phoneController,
                  validator: (value) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = RegExp(pattern);
                    if (value!.isEmpty) {
                      return 'Add your phone No';
                    } else if (value.length != 10 || !regExp.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Obx(() => sendOtpController.isLoading?Center(child: CircularProgressIndicator(),):
                ElevatedButton(
                  onPressed: () async {
                    String phoneNumber = sendOtpController.phoneController.text;
                    if (_formKey.currentState!.validate()) {
                      if (phoneNumber.length == 10) {
                        sendOtpController.sendOtp(
                            phoneNumber: phoneNumber,
                            groupId: 1703228300417,
                            context: context,
                            onSuccess: (){
                              sendOtpController.clearData();
                              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerifyScree(phoneNumber: phoneNumber),
                          ),
                        );
                            }
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please enter a valid 10-digit phone number.'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Send Otp"),
                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
