import 'package:meta/meta.dart';

@immutable
class PullRequest {
  final String title;
  final String author;
  final List<String> reviewers;

  const PullRequest(this.title, this.author, this.reviewers);
}
