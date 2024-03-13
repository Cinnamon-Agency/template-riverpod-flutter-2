import 'package:cinnamon_riverpod_2/features/planner/trip_creator/widgets/trip_creator_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TripCreatorPage extends StatelessWidget {
  const TripCreatorPage({Key? key, this.editTripItineraryId}) : super(key: key);

  final String? editTripItineraryId;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GestureDetector(
          onTap: FocusManager.instance.primaryFocus?.unfocus,
          child: Scaffold(
            appBar: AppBar(
              title: editTripItineraryId == null ? const Text('Create a new trip') : const Text('Edit trip'),
              leading: InkWell(
                onTap: GoRouter.of(context).pop,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TripCreatorForm(
                editTripItineraryId: editTripItineraryId,
              ),
            ),
          ),
        ),
      );
}
