import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/gen/assets.gen.dart';
import 'package:gritti_app/helpers/ui_helpers.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../constants/text_font_style.dart';
import '../../helpers/navigation_service.dart';

enum WeightUnit { lbs, kg }

enum HeightUnit { inch, cm }

class UnitMetricScreen extends StatefulWidget {
  const UnitMetricScreen({super.key});

  @override
  State<UnitMetricScreen> createState() => _UnitMetricScreenState();
}

class _UnitMetricScreenState extends State<UnitMetricScreen> {
  WeightUnit selectedWeightUnit = WeightUnit.lbs;
  HeightUnit selectedHeightUnit = HeightUnit.cm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Unit & Metrics",
        onPressed: () {
          NavigationService.goBack;
        },
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIHelper.verticalSpace(20.h),
            Text(
              "Weight Unit",
              style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
              ),
            ),

            UIHelper.verticalSpace(20.h),

            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border.all(color: Color(0xFFEDF1FC)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                spacing: 16.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pounds (Ibs)",
                        style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w400,
                            ),
                      ),

                      MSHCheckbox(
                        style: MSHCheckboxStyle.fillScaleCheck,
                        size: 20.sp,
                        value: selectedWeightUnit == WeightUnit.lbs,
                        onChanged: (value) {
                          setState(() {
                            selectedWeightUnit = WeightUnit.lbs;
                          });
                        },
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Color(0xFFF566F9),
                              uncheckedColor: Color(0xFFD4D4D8),
                            ),
                      ),
                    ],
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kilograms (kg)",
                        style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w400,
                            ),
                      ),

                      MSHCheckbox(
                        style: MSHCheckboxStyle.fillScaleCheck,
                        size: 20.sp,
                        value: selectedWeightUnit == WeightUnit.kg,
                        onChanged: (value) {
                          setState(() {
                            selectedWeightUnit = WeightUnit.kg;
                          });
                        },
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Color(0xFFF566F9),
                              uncheckedColor: Color(0xFFD4D4D8),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(30.h),
            Text(
              "Height Unit",
              style: TextFontStyle.headLine16cFFFFFFWorkSansW600.copyWith(
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
              ),
            ),

            UIHelper.verticalSpace(10.h),

            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border.all(color: Color(0xFFEDF1FC)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                spacing: 16.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Inches (in)",
                        style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w400,
                            ),
                      ),

                      MSHCheckbox(
                        style: MSHCheckboxStyle.fillScaleCheck,
                        size: 20.sp,
                        value: selectedHeightUnit == HeightUnit.inch,
                        onChanged: (value) {
                          setState(() {
                            selectedHeightUnit = HeightUnit.inch;
                          });
                        },
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Color(0xFFF566F9),
                              uncheckedColor: Color(0xFFD4D4D8),
                            ),
                      ),
                    ],
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Centimeters (cm)",
                        style: TextFontStyle.headLine16cFFFFFFWorkSansW600
                            .copyWith(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.w400,
                            ),
                      ),

                      MSHCheckbox(
                        style: MSHCheckboxStyle.fillScaleCheck,
                        size: 20.sp,
                        value: selectedHeightUnit == HeightUnit.cm,
                        onChanged: (value) {
                          setState(() {
                            selectedHeightUnit = HeightUnit.cm;
                          });
                        },
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                              checkedColor: Color(0xFFF566F9),
                              uncheckedColor: Color(0xFFD4D4D8),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            UIHelper.verticalSpaceMediumLarge,

            Image.asset(
              Assets.images.instantUpdate.path,
              width: 1.sw,
              height: 200.h,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
