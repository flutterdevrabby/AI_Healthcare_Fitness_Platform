import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gritti_app/common_widget/custom_network_image.dart';
import 'package:gritti_app/common_widget/custom_text_field.dart';
import 'package:gritti_app/constants/text_font_style.dart';
import 'package:gritti_app/gen/assets.gen.dart';
import 'package:gritti_app/helpers/loading_helper.dart';
import 'package:gritti_app/helpers/navigation_service.dart';
import 'package:gritti_app/helpers/toast.dart';
import 'package:gritti_app/helpers/ui_helpers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../common_widget/picker_file_widget.dart';
import '../../networks/api_acess.dart';
import '../../provider/file_picker_provider.dart';
import '../settings/data/rx_get_profile_info/model/user_info_response.dart';

class EditProfileScreen extends StatefulWidget {
  final Data data;
  const EditProfileScreen({super.key, required this.data});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fullNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _targetWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.data.name ?? "";
    _ageController.text = widget.data.userInfo?.age.toString() ?? "";

    _weightController.text =
        widget.data.userInfo?.currentWeight.toString() ?? "";

    _heightController.text = widget.data.userInfo?.height.toString() ?? "";

    _targetWeightController.text =
        widget.data.userInfo?.targetWeight.toString() ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _targetWeightController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var providers = Provider.of<FilePickerProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Edit Profile",
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            updateProfileRxObj
                .userInfoRx(
                  age: int.tryParse(_ageController.text),
                  height: int.tryParse(_heightController.text),
                  name: _fullNameController.text,
                  targetWeight: int.tryParse(_targetWeightController.text),
                  weight: int.tryParse(_weightController.text),
                  avatar: providers.file,
                )
                .waitingForFuture()
                .then((success) {
                  if (success) {
                    userInfoRxObj.userInfoRx().waitingForFuture().then((
                      suuces,
                    ) {
                      if (suuces) {
                        ToastUtil.showShortToast(
                          "Profile Updated Successfully",
                        );
                      }
                    });
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

              UIHelper.verticalSpace(30.h),

              Consumer<FilePickerProvider>(
                builder: (context, provider, child) {
                  return Align(
                    alignment: AlignmentGeometry.center,
                    child: Stack(
                      children: [
                        ClipOval(
                          child:
                              provider.file != null
                                  ? Image.file(
                                    File(provider.file!.path),
                                    width: 120.w,
                                    height: 110.h,
                                    fit: BoxFit.cover,
                                  )
                                  : CustomCachedNetworkImage(
                                    imageUrl: widget.data.avatar ?? "",
                                    width: 120.w,
                                    height: 110.h,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    16.r,
                                  ),
                                ),
                                context: context,
                                builder:
                                    (_) => PickerFileWidget(
                                      onTapCamera: () {
                                        provider.getFileFromUser(
                                          ImageSource.camera,
                                        );
                                        NavigationService.goBack;
                                      },
                                      onTapGallery: () {
                                        provider.getFileFromUser(
                                          ImageSource.gallery,
                                        );
                                        NavigationService.goBack;
                                      },
                                    ),
                              );
                            },
                            child: SvgPicture.asset(
                              Assets.icons.editIcon,
                              width: 24.w,
                              height: 24.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              UIHelper.verticalSpace(20.h),

              Align(
                child: Text(
                  "Tap to change photo",
                  style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w300,

                    fontSize: 12.sp,
                  ),
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Text(
                  "Full Name",
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "name is required";
                    }
                    return null;
                  },
                  hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                      .copyWith(
                        color: Color(0xFF999999),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  controller: _fullNameController,
                  hintText: "Enter your full name",
                ),
              ),

              //age
              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Row(
                  spacing: 20.w,
                  children: [
                    Expanded(
                      child: Text(
                        "Age",
                        style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Weight",
                        style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(10.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),

                child: Row(
                  spacing: 20.w,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "age is required";
                          }
                          return null;
                        },
                        hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF999999),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                        controller: _ageController,
                        hintText: "Age",
                      ),
                    ),

                    Expanded(
                      child: CustomTextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Weight is required";
                          }
                          return null;
                        },
                        hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF999999),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                        controller: _weightController,
                        hintText: "Weight",
                      ),
                    ),
                  ],
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Text(
                  "Height",
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "height is required";
                    }
                    return null;
                  },
                  hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                      .copyWith(
                        color: Color(0xFF999999),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  controller: _heightController,
                  hintText: "Height",
                ),
              ),

              UIHelper.verticalSpace(20.h),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
                child: Text(
                  "Target Weight",
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
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "target weight is required";
                    }
                    return null;
                  },
                  hintStyle: TextFontStyle.headLine16cFFFFFFWorkSansW600
                      .copyWith(
                        color: Color(0xFF999999),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                  controller: _targetWeightController,
                  hintText: "kg/lbs",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
