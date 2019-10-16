import 'dart:ui';

import 'package:creative_run/model/image_data.dart';
import 'package:creative_run/model/stats.dart';
import 'package:equatable/equatable.dart';

class ProjectDetails extends Equatable {
  final int id;
  final String name;
  final DateTime date;
  final String url;
  final List<String> categories;
  final String imageUrl;
  final String thumbnailUrl;
  final Stats stats;
  final Color color;
  final String description;
  final List<ImageData> images;

  ProjectDetails(
    this.id,
    this.name,
    this.date,
    this.url,
    this.categories,
    this.imageUrl,
    this.thumbnailUrl,
    this.stats,
    this.color,
    this.description,
    this.images,
  ) : super([
          id,
          name,
          date,
          url,
          categories,
          imageUrl,
          thumbnailUrl,
          stats,
          color,
          description,
          images
        ]);
}
