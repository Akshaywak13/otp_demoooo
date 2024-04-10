import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_demooo/controller/phone_controller.dart';
import 'package:otp_demooo/view/new/otp_verify_page.dart';

class PhoneValidat extends StatefulWidget {
  const PhoneValidat({super.key});

  @override
  State<PhoneValidat> createState() => _PhoneValidat();
}

class _PhoneValidat extends State<PhoneValidat> {
  SendOtpController sendOtpController = Get.put(SendOtpController());
  TextEditingController countrycode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/img1.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verifcation",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We nneed to register your phone before getting started !",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countrycode,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        )),
                    const SizedBox(
                      height: 35,
                      child: VerticalDivider(color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: sendOtpController.phoneController,
                        maxLines: 1,

                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        // controller: sendOtpController.phoneController,
                        validator: (value) {
                          // String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          // RegExp regExp = RegExp(pattern);
                          if (value!.isEmpty) {
                            throw ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Add your phone No')));
                          } else if (value.length != 10
                              //|| !regExp.hasMatch(value)
                              ) {
                            throw ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter valid mobile number')));
                            //'Please enter valid mobile number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter phone number"),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String phoneNumber = sendOtpController.phoneController.text;
                    if (_formKey.currentState!.validate()) {
                      if (phoneNumber.length == 10) {
                        sendOtpController.sendOtp(
                            phoneNumber: sendOtpController.phoneController.text,
                            context: context,
                            groupId: 1703228300417,
                            onSuccess: (){
                              sendOtpController.clearData();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerify(phoneNumber: phoneNumber,)));
                            },
                            );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Please enter a valid 10-digit phone number.')));
                    }
                  },
                  child: const Text(
                    "Send the code ",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
