import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  static getRequest(String url) async {
    var response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      } else {
        // print('response statusCode $response.statusCode');
      }
    } catch (e) {
      // print('Catched Error $e');
    }
  }

  static postRequest(String url, Map data, Function function) async {
    var response = await http.post(Uri.parse(url), body: data);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = response.body;
        return function(jsonData);
      } else {}
    } catch (e) {
      return e;
    }
  }

  // static postRequestWithFile(
  //     {required String url,
  //     required Map data,
  //     required File file,
  //     required Function function,
  //     required String imageName}) async {
  //   var request = http.MultipartRequest('POST', Uri.parse(url));

  //   var lenth = await file.length();
  //   var stream = http.ByteStream(file.openRead());
  //   var multipartFile = http.MultipartFile(imageName, stream, lenth,
  //       filename: basename(file.path));
  //   request.files.add(multipartFile);
  //   data.forEach((key, value) {
  //     request.fields[key] = value;
  //   });
  //   var sendRequset = await request.send();
  //   var response = await http.Response.fromStream(sendRequset);
  //   try {
  //     if (sendRequset.statusCode == 200 || sendRequset.statusCode == 201) {
  //       var jsonData = response.body;
  //       return function(jsonData);
  //     } else {
  //       // print('response statusCode $response.statusCode');
  //     }
  //   } catch (e) {
  //     // print('Catched Error $e');
  //   }
  // }
}
