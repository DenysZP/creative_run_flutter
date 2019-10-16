import 'package:equatable/equatable.dart';

class Stats extends Equatable {
  final int views;
  final int appreciations;
  final int comments;

  Stats(this.views, this.appreciations, this.comments)
      : super([views, appreciations, comments]);

  @override
  String toString() {
    return 'Stats{views: $views, appreciations: $appreciations, comments: $comments}';
  }
}
