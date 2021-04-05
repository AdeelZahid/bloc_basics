// import 'dart:convert';
// import 'package:bloc_beginner/constants/strings.dart';
// import 'package:bloc_beginner/model/newsInfo.dart';
// import 'package:http/http.dart' as http;

// // ignore: camel_case_types
// class API_Manager {
//   Future<NewsModel> getNews() async {
//     var client = http.Client();
//     var newsModel;

//     try {
//       var response = await client.get(Strings.news_url);
//       print('RESPONSE: $response');
//       if (response.statusCode == 200) {
//         var jsonString = response.body;
//         var jsonMap = json.decode(jsonString);

//         newsModel = NewsModel.fromJson(jsonMap);
//       }
//     } catch (Exception) {
//       return newsModel;
//     }
//     return newsModel;
//   }
// }
