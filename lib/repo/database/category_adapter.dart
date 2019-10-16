import 'package:creative_run/model/category.dart';

class CategoryAdapter {
  static Category adaptFromJson(Map<String, dynamic> data) {
    return Category(
      data["id"],
      data["name"],
    );
  }

  static Map<String, dynamic> adaptToJson(Category data) {
    return {
      "id": data.id,
      "name": data.name,
    };
  }
}
