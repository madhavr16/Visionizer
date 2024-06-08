import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:visionizer/feature/prompt/secrets.dart';

class PromptRepo{
  static Future<Uint8List?>generateImage(String prompt) async{
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';
    Map<String, dynamic> headers = {
  'Authorization': 'Bearer$mySecret',
  };
  Map<String, dynamic> payload = {
    'prompt': prompt,
    'style_id': '29',
    'aspect_ratio': '1:1',
    'cfg': '1',
    'seed': '1',
    'high_res_results': '0'
  };

  FormData formData = FormData.fromMap(payload);

  Dio dio = Dio();
  dio.options = BaseOptions(
    headers: headers,
    responseType: ResponseType.bytes
  );
  final response = await dio.post(url, data: formData);
  if(response.statusCode == 200){
    log(response.data.runtimeType.toString());
    log(response.data.toString());
    Uint8List uint8list = Uint8List.fromList(response.data);
    return uint8list;
  }else{
    return null;
  }
    } catch (e) {
      log(e.toString());
    }
  }
}
