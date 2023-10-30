import 'package:cinnamon_riverpod_2/features/planner/planner_creator/widgets/planner_creator_form.dart';
import 'package:flutter/material.dart';

class PlannerCreatorPage extends StatelessWidget {
  const PlannerCreatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(children: [
          //  Container(color: Colors.red, height: 100,),
          Expanded(child: PlannerCreatorForm()),
        ]),
  );
}
