import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_widget/latest_appbar_widget.dart';
import '../../constants/text_font_style.dart';
import '../../helpers/navigation_service.dart';

class GeneralNotificationScreen extends StatefulWidget {
  const GeneralNotificationScreen({super.key});

  @override
  State<GeneralNotificationScreen> createState() =>
      _GeneralNotificationScreenState();
}

class _GeneralNotificationScreenState extends State<GeneralNotificationScreen> {
  final _controller = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Notification",
        onPressed: () {
          NavigationService.goBack;
        },
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Preferences',
              style: TextFontStyle.headLine18c051F42PoppinsW600,
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("General Notification"),

              subtitle: Text("Get reminded about your scheduled workouts"),

              trailing: AdvancedSwitch(
                controller: _controller,
                activeColor: Color(0xFFF566A9),
                inactiveColor: Colors.grey,
                height: 30,
                width: 50,

                borderRadius: BorderRadius.all(const Radius.circular(15)),

                enabled: true,
                disabledOpacity: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
