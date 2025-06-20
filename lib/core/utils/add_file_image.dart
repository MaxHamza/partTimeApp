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

Future<File?> pickCv()async{
  final result= await FilePicker.platform.pickFiles(allowMultiple: false,
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx','pptx'],
  );
  String name='';
  final file=result?.files.first;
  if(result!=null&& result.files.single.path!=null){
    File cvFile = File(file!.path!); // هذا هو المسار المحلي الصحيح!
    name= result.files.single.name!;
    print('✅ You chose an CV: $cvFile');
    return cvFile;
  }
  else{
    print('❌ You didn\'t choose any File');
    return null;
  }
}

