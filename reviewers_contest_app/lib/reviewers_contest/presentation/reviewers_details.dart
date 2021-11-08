import 'package:flutter/material.dart';
import 'package:reviewers_contest_app/reviewers_contest/application/reviewers_contest_bloc.dart';

class ReviewersDetails extends StatelessWidget {
  final Loaded state;
  const ReviewersDetails(
    this.state, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 32.0,
            right: 32.0,
            top: 8.0,
          ),
          child: Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Reviewer"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Number of PRs"),
                  )
                ],
              ),
              ...state.reviewers
                  .map((e) => TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.name),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.numberOfPRs.toString()),
                        )
                      ]))
                  .toList()
            ],
          ),
        ),
      ],
    );
  }
}
