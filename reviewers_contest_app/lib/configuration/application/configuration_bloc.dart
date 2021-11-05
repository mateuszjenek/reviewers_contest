import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'configuration_event.dart';
part 'configuration_state.dart';

@injectable
class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  ConfigurationBloc()
      : super(ConfigurationState(
          DateTime.now().subtract(const Duration(days: 14)),
          DateTime.now(),
          null,
        )) {
    on<TimePeriodChanged>((event, emit) {
      emit(ConfigurationState(
        event.startDate,
        event.endDate,
        state.repository,
      ));
    });
    on<RepositoryChanged>((event, emit) {
      emit(ConfigurationState(
        state.startDate,
        state.endDate,
        event.repository,
      ));
    });
  }
}
