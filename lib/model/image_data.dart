import 'package:equatable/equatable.dart';

class ImageData extends Equatable {
  final String src;
  final int width;
  final int height;

  ImageData(this.src, this.width, this.height) : super([src, width, height]);
}
