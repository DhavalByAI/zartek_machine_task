import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Core/Const/image_const.dart';
import '../../Core/Utils/app_colors.dart';
import '../../Widgets/c_button.dart';
import 'auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(GifConst.firebase),
            GetBuilder<AuthController>(builder: (_) {
              return Column(
                children: [
                  cButton(
                    'Sign In With Google',
                    btnColor: AppColors.blue,
                    icon: IconConst.google,
                    onTap: () {
                      _.signInWithGoogle();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _.isMobile
                      ? _.isOtp
                          ? Padding(
                              padding:
                                  const EdgeInsets.all(16).copyWith(top: 0),
                              child: TextField(
                                controller: _.otpController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                decoration:
                                    InputDecoration(labelText: 'Enter OTP'),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.all(16).copyWith(top: 0),
                              child: TextField(
                                controller: _.phoneNumberController,
                                onChanged: (value) {
                                  _.update();
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                autofocus: true,
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    errorText:
                                        _.mobileValidation() && _.isChecked
                                            ? 'Incorrect Mobile Number'
                                            : null),
                              ),
                            )
                      : SizedBox(),
                  cButton(
                      _.isMobile
                          ? _.isOtp
                              ? 'Verify'
                              : 'Get Otp'
                          : 'Sign In With Mobile',
                      btnColor: AppColors.green,
                      icon: IconConst.phone, onTap: () async {
                    if (_.isMobile) {
                      _.isChecked = true;
                      if (_.isOtp) {
                        _.verifyOtp();
                      } else {
                        if (!_.mobileValidation()) {
                          _.verifyMobile();
                          FocusScope.of(context).unfocus();
                        }
                      }
                    } else {
                      _.isMobile = true;
                    }
                    _.update();
                  }),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
