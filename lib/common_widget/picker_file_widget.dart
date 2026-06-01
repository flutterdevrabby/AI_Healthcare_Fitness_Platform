import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PickerFileWidget extends StatelessWidget {
  final VoidCallback onTapCamera;
  final VoidCallback onTapGallery;
  const PickerFileWidget({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 120.h,
      color: Colors.white,
      child: ListView(
        children: [
          ListTile(
            onTap: onTapCamera,

            leading: Icon(Icons.camera),
            title: Text("Camera"),
          ),

          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text("Gallery"),
            onTap: onTapGallery,
          ),
        ],
      ),
    );
  }
}
