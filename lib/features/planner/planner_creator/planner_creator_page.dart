import 'package:cinnamon_riverpod_2/features/planner/planner_creator/widgets/planner_creator_form.dart';
import 'package:flutter/material.dart';

class PlannerCreatorPage extends StatelessWidget {
  const PlannerCreatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          Expanded(child: PlannerCreatorForm()),
        ]),
      );
}
