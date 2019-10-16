import 'dart:ui';

import 'package:creative_run/model/stats.dart';
import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String title;
  final DateTime date;
  final String url;
  final List<String> categories;
  final String imageUrl;
  final String thumbnailUrl;
  final Stats stats;
  final Color color;

  Project(
    this.id,
    this.title,
    this.date,
    this.url,
    this.categories,
    this.imageUrl,
    this.thumbnailUrl,
    this.stats,
    this.color,
  ) : super([id, title, date, url, categories, thumbnailUrl, stats, color]);

  @override
  String toString() {
    return 'Project{id: $id, title: $title, date: $date, url: $url, categories: $categories, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, stats: $stats, colors: $color}';
  }
}
