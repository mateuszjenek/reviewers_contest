import 'package:meta/meta.dart';

@immutable
abstract class PullRequestRepositoryFailure {}

class UnknownFailure extends PullRequestRepositoryFailure {}
