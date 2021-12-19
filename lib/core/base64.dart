import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class Base64Converter {
  static convertImageToBase64({FilePickerResult? file}) {
    String mine = '';
    if (',jpg,jpeg,png,gif,bmp,svg'
        .contains(file!.files.first.extension ?? '!@#%^&*(^&*')) {
      mine = 'image';
    } else {
      mine = 'application';
    }
    String base64Image =
        "data:$mine/${file.files.first.extension?.toLowerCase()};base64," +
            base64Encode(file.files.first.bytes!);
    // String base64Image = base64Encode(bytes);
    print("img_pan : $base64Image");
    return base64Image;
    // return 'image';
  }
}
