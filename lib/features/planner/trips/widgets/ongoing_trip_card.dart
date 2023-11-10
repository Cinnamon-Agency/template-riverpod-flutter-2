import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/tertiary_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OngoingTripCard extends StatelessWidget {
  final TripItinerary itinerary;

  const OngoingTripCard({
    super.key,
    required this.itinerary,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocation = itinerary.currentLocation;
    final nextLocation = itinerary.nextLocation;

    return Container(
      height: 184,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor,
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: itinerary.imageUrl!,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.7)
                    ],
                    begin: const FractionalOffset(0, 0),
                    end: const FractionalOffset(0, 1),
                    stops: const [0.0, 0.8, 1.0],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itinerary.name,
                      style: context.theme.textTheme.headlineSmall
                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    currentLocation != null
                        ? Text(
                            "Current: ${currentLocation.name} (${currentLocation.duration.inMinutes} min)",
                            style: context.theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                          )
                        : const Text("-"),
                    nextLocation != null
                        ? Text(
                            "Next: ${nextLocation.name} (${nextLocation.duration.inMinutes} min)",
                            style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          )
                        : const Text("-"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 110,
                      child: TertiaryButton(
                        text: 'Details >',
                        onPressed: () {
                          GoRouter.of(context).push(RoutePaths.tripDetails, extra: itinerary.id);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
