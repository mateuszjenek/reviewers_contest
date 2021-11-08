// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'authentication/application/auth_bloc.dart' as _i19;
import 'authentication/domain/i_github_sso.dart' as _i4;
import 'authentication/domain/i_reviewers_contest_sso.dart' as _i12;
import 'authentication/infrastructure/github_sso.dart' as _i5;
import 'authentication/infrastructure/reviewers_contest_sso.dart' as _i13;
import 'configuration/application/configuration_bloc.dart' as _i3;
import 'configuration/application/repositories_bloc.dart' as _i17;
import 'configuration/domain/i_repository_repository.dart' as _i10;
import 'configuration/infrastructure/repository_repository.dart' as _i11;
import 'reviewers_contest/application/reports_generator_bloc.dart' as _i16;
import 'reviewers_contest/application/reviewers_contest_bloc.dart' as _i18;
import 'reviewers_contest/domain/i_pull_request_repository.dart' as _i6;
import 'reviewers_contest/domain/i_report_generator.dart' as _i8;
import 'reviewers_contest/domain/i_reviewers_contest_winner_calculator.dart'
    as _i14;
import 'reviewers_contest/infrastructure/pull_request_repository.dart' as _i7;
import 'reviewers_contest/infrastructure/report_generator.dart' as _i9;
import 'reviewers_contest/infrastructure/reviewers_contest_winner_calculator.dart'
    as _i15;

const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ConfigurationBloc>(() => _i3.ConfigurationBloc());
  gh.factory<_i4.IGithubSSO>(() => _i5.GithubSSO(), registerFor: {_prod});
  gh.factory<_i6.IPullRequestRepository>(() => _i7.PullRequestRepository(),
      registerFor: {_prod});
  gh.factory<_i8.IReportGenerator>(() => _i9.ReportGenerator(),
      registerFor: {_prod});
  gh.factory<_i10.IRepositoryRepository>(() => _i11.RepositoryRepository(),
      registerFor: {_prod});
  gh.factory<_i12.IReviewersContestSSO>(() => _i13.GithubStatsSSO(),
      registerFor: {_prod});
  gh.factory<_i14.IReviewersContestWinnerCalculator>(
      () => _i15.ReviewersContestWinnerCalculator());
  gh.factory<_i16.ReportsGeneratorBloc>(
      () => _i16.ReportsGeneratorBloc(get<_i8.IReportGenerator>()));
  gh.factory<_i17.RepositoriesBloc>(
      () => _i17.RepositoriesBloc(get<_i10.IRepositoryRepository>()));
  gh.factory<_i18.ReviewersContestBloc>(() => _i18.ReviewersContestBloc(
      get<_i6.IPullRequestRepository>(),
      get<_i14.IReviewersContestWinnerCalculator>()));
  gh.factory<_i19.AuthBloc>(() =>
      _i19.AuthBloc(get<_i4.IGithubSSO>(), get<_i12.IReviewersContestSSO>()));
  return get;
}
