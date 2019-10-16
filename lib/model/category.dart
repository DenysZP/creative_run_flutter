import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;

  Category(this.id, this.name) : super([id, name]);

  @override
  String toString() {
    return 'Category{id: $id, name: $name}';
  }
}
