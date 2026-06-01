import 'package:flutter/material.dart';
import 'package:gritti_app/helpers/all_routes.dart';
import 'package:gritti_app/helpers/navigation_service.dart';

import '../../common_widget/latest_appbar_widget.dart';
import 'privacy_card_widget.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  List<Map<String, dynamic>> dataList = [
    {
      "title": "Privacy Policy",
      "subtitle": "View Privacy Policy",
      "content":
          "Read our privacy policy to understand how we collect, use, and protect your personal information.",
    },

    //
    {
      "title": "Terms of Service",
      "subtitle": "View Terms of Service",
      "content":
          "Review our terms of service to understand the rules and guidelines for using our platform.",
    },

    {
      "title": "Cookie Policy",
      "subtitle": "View Cookie Policy",
      "content":
          "Learn about how we use cookies and similar technologies to enhance your browsing experience.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        titleText: "Privacy",
        onPressed: () {},
        isButton: false,
      ),

      body: ListView.builder(
        itemCount: dataList.length,
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) {
          var datam = dataList[index];
          return PrivacyCardWidget(
            data: datam,
            onTap: () {
              NavigationService.navigateToWithArgs(Routes.webViewScreen, {
                "url":
                    index == 0
                        ? "https://quiz.dolcereset.com/policy"
                        : index == 1
                        ? "https://quiz.dolcereset.com/terms"
                        : "https://quiz.dolcereset.com/gdpr",

                "index": index,
              });
            },
          );
        },
      ),
    );
  }
}
