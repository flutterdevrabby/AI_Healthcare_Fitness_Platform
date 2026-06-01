import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/common_widget/custom_text_field.dart';
import 'package:gritti_app/constants/text_font_style.dart';
import 'package:gritti_app/helpers/loading_helper.dart';
import 'package:gritti_app/helpers/navigation_service.dart';
import 'package:gritti_app/helpers/toast.dart';
import 'package:gritti_app/helpers/ui_helpers.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../constants/validation.dart';
import '../../networks/api_acess.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  //final _oldPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //_oldPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Change password",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            changePasswordRxObj
                .changePasswordRx(
                  password: _newPassword.text,
                  passwordConfirmation: _confirmPassword.text,
                )
                .waitingForFuture()
                .then((success) {
                  if (success) {
                    ToastUtil.showShortToast("Password Changed Successfully");

                    NavigationService.goBack;
                  }
                });
          }
        },
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Divider(color: Color(0xFFCCCCCC), thickness: 1),

              UIHelper.verticalSpace(20.h),

              // Padding(
              //   padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              //   child: Text(
              //     "Old Password",
              //     style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
              //       color: Color(0xFF000000),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // UIHelper.verticalSpace(10.h),

              // Padding(
              //   padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              //   child: CustomTextField(
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return "Old password is required";
              //       }
              //       return null;
              //     },
              //     hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
              //         .copyWith(
              //           color: Color(0xFF999999),
              //           fontSize: 14.sp,
              //           fontWeight: FontWeight.w400,
              //         ),
              //     controller: _oldPassword,
              //     hintText: "old password",
              //   ),
              // ),

              // UIHelper.verticalSpace(20.h),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Text(
                  "New Password",
                  style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  validator: passwordValidation,
                  hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                      .copyWith(
                        color: Color(0xFF999999),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  controller: _newPassword,
                  hintText: "New password",
                ),
              ),

              // Confirm
              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Text(
                  "Confirm Password",
                  style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  validator:
                      (value) =>
                          confirmPasswordValidation(value, _newPassword.text),
                  hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                      .copyWith(
                        color: Color(0xFF999999),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  controller: _confirmPassword,
                  hintText: "Confirm password",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
