import 'dart:developer';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

const presetName = "vbp2w4wt";

Future<Map> uploadImage(File file) async {
  final cloudinary = CloudinaryPublic("dtvlxdd2u", 'vbp2w4wtZ');
  final res = await cloudinary.uploadFile(CloudinaryFile.fromFile(file.path),
      uploadPreset: presetName);
  log(res.toMap().toString(), name: 'cloudinary');
  final imageData = {"url": res.secureUrl, "publicId": res.publicId};
  return imageData;
}

// uploadImage(File file) async {
//   final url = Uri.parse('https://api.cloudinary.com/v1_1/dtvlxdd2u/upload');
//   final bytes = await file.readAsBytes();
//   final request = http.MultipartRequest('POST', url)
//     ..fields['upload_preset'] = 'q3xsw0fd'
//     ..files.add(http.MultipartFile.fromBytes('file', bytes));
//   final resp = await request.send();
//   print(resp);
//   if (resp.statusCode == 200) {
//     final responseData = await resp.stream.toBytes();
//     final responseString = String.fromCharCodes(responseData);
//     final jsonMap = jsonDecode(responseString);
//     print(jsonMap);
//   }
// }
