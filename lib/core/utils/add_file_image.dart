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
Future<String?>pickCv()async{
  final result= await FilePicker.platform.pickFiles(allowMultiple: true,
  type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx','pptx'],
  );
  if(result!=null&& result.files.single.path!=null){
    String path= result.files.single.path!;
    print('✅ You chose an CV: $path');
    return path;
  }
  else{
    print('❌ You didn\'t choose any File');
    return null;
  }
}

