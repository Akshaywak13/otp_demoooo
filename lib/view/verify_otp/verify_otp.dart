import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_demooo/controller/verify_controller.dart';
import 'package:pinput/pinput.dart';

class VerifyScree extends StatefulWidget {
  const VerifyScree({super.key, required this.phoneNumber});
  final String? phoneNumber;

  @override
  State<VerifyScree> createState() => _VerifyScreeState();
}

VerifyController verifyController = Get.put(VerifyController());
final _formkey = GlobalKey<FormState>();

class _VerifyScreeState extends State<VerifyScree> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: const Text("Verify Otp"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Pinput(
                controller: verifyController.otpController,
                length: 6,
                keyboardType: TextInputType.number,
                validator: (String? value) {
                  if (value?.length != 6 && value!.length < 6) {
                    return "Please enter the 6 digit otp";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(() => verifyController.isLoading?Center(child: CircularProgressIndicator(),):
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      verifyController.verifyOtp(
                        context: context,
                        number: widget.phoneNumber.toString(),
                        otp: int.parse(verifyController.otpController.text),
                      );

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                    }
                  },
                  child: const Text("Verify"))
                  )
            ]),
          ),
        ),
      ),
    );
  }
}
