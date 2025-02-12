// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:compaz_radio/helper/api_helper.dart';
// import 'package:compaz_radio/model/radio_model.dart';
//
//
// class ApiServices{
//   static var client = http.Client();
//
//   //get method
//   static Future<RadioModel?> radioApi() async {
//     final response = await client.get(ApiHelper.url('/nowplaying/ravelink'));
//
//     if (response.statusCode == 200) {
//       var jsonString = jsonDecode(response.body);
//       // ignore: avoid_print
//       print('--------from radio api data: $jsonString');
//       return RadioModel.fromJson(jsonString);
//     }
//     return null;
//   }
//
// }