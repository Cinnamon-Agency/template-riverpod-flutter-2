import 'package:cinnamon_riverpod_2/features/planner/trips/widgets/trip_itinerary_card.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:flutter/material.dart';

class TripSection extends StatelessWidget {
  final String sectionTitle;
  final String emptyMessage;
  final List<TripItinerary> itineraries;

  const TripSection({
    super.key,
    required this.sectionTitle,
    required this.emptyMessage,
    required this.itineraries,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                sectionTitle,
                style: context.theme.textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        if (itineraries.isEmpty)
          Text(
            emptyMessage,
            style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
          ),
        ListView.separated(
          itemBuilder: (_, index) => TripItineraryCard(itinerary: itineraries[index]),
          separatorBuilder: (_, __) => const SizedBox(
            height: 16,
          ),
          itemCount: itineraries.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}
