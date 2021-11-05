import 'package:meta/meta.dart';

@immutable
abstract class PullRequestRepositoryFailure {}

class ConnectionFailure extends PullRequestRepositoryFailure {}
