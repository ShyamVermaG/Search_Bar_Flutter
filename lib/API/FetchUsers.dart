import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/User.dart';


Future<List<User>> fetchUsers() async {

  final response = await http.get(Uri.parse('https://swapi.dev/api/people'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List items = jsonResponse['results'];
    // print("error"+items['user']);

    return items.map((item) => User.fromJson(item)).toList();
  } else {
    print("error");
    throw Exception('Failed to load items');
  }
}
