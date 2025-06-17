import 'package:file_picker/file_picker.dart';
import 'dart:io';

Future<String?> pickImageFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null && result.files.single.path != null) {
    String path = result.files.single.path!;
    print('✅ You chose an image: $path');
    return path;
  } else {
    print('❌ You didn\'t choose any image');
    return null;
  }
}

