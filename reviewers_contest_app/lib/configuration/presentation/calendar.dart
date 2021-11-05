import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:reviewers_contest_app/configuration/application/configuration_bloc.dart';

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SfDateRangePicker(
              onSelectionChanged: (args) {
                final pickerDateRange = (args.value as PickerDateRange);
                context.read<ConfigurationBloc>().add(TimePeriodChanged(
                      pickerDateRange.startDate!,
                      pickerDateRange.endDate ?? pickerDateRange.startDate!,
                    ));
              },
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                  context.read<ConfigurationBloc>().state.startDate,
                  context.read<ConfigurationBloc>().state.endDate)),
        ],
      ),
    );
  }
}
