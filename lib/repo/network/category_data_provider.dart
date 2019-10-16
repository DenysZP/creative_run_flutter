import 'dart:convert';

import 'package:creative_run/model/category.dart';
import 'package:http/http.dart';

Future<List<Category>> fetchCategories(Client httpClient) async {
  final response = await httpClient.get("v2/fields");
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final fields = data["fields"] as List;
    final popular = data["popular"] as List;
    final dataList = fields + popular;
    return dataList.map((item) {
      return Category(
        item["id"],
        item["name"],
      );
    }).toList();
  } else {
    throw Exception('error fetching categories');
  }
}
