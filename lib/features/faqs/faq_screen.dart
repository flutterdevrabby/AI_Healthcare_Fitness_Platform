import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gritti_app/networks/api_acess.dart';

import '../../constants/text_font_style.dart';
import 'data/model/faq_repsonse.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();

    faqRxObj.faqRx();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs", style: TextFontStyle.headLine16c0F172AnterW600),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyActions: true,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder<FaqResponse>(
        stream: faqRxObj.faqRxStrewam,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasData) {
            return ListView.builder(
              itemCount: asyncSnapshot.data?.data?.faq?.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),

              itemBuilder: (_, index) {
                var datum = asyncSnapshot.data?.data?.faq?[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.w,
                        color: const Color(0xFFE6E6E6),
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),

                  child: ExpansionTile(
                    dense: true,

                    childrenPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    title: Text(
                      datum?.question ?? "",
                      style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                        color: const Color(0xFF1A1A1A),
                        fontSize: 14.sp,
                      ),
                    ),
                    children: [

                      Html(data: datum?.answer ?? "",)
                      // Text(
                      //   datum?.answer ?? "",
                      //   style: TextFontStyle.headLine16c0F172AnterW600.copyWith(
                      //     color: const Color(0xFF7F7F7F),
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 12.sp,
                      //   ),
                      // ),

                      //    UIHelper.verticalSpace(10.h),
                    ],
                  ),
                );
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
