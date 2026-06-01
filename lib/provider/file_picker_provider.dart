import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:gritti_app/helpers/toast.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerProvider extends ChangeNotifier {
  File? _file;

  File? get file => _file;

  Future<void> getFileFromUser(ImageSource source) async {
    final image = ImagePicker();

    final XFile? picked = await image.pickImage(source: source);

    if (picked != null) {
      _file = File(picked.path);
    } else {
      ToastUtil.showShortToast("you havn't any selected image.");
    }

    notifyListeners();
  }
}
