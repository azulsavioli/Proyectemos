// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../model/schedules_model.dart';

// class GoogleCalendarApi {
//   static Future<List<Data>> getData() async {
//     String url = '';
//     url = '';
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         List<Data> list = parseSchedules(response.body);
//         return list;
//       } else {
//         throw Exception("Requisition error");
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   static List<Data> parseSchedules(String responseBody) {
//     final parsed = json.decode(responseBody);
//     return parsed["data"].map<Data>((json) => Data.fromJson(json)).toList();
//   }
// }
