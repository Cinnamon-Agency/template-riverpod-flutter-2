import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinnamon_riverpod_2/features/shared/buttons/tertiary_button.dart';
import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:cinnamon_riverpod_2/infra/planner/model/trip_itinerary.dart';
import 'package:cinnamon_riverpod_2/routing/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TripItineraryCard extends StatelessWidget {
  final TripItinerary itinerary;

  const TripItineraryCard({
    super.key,
    required this.itinerary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(RoutePaths.tripDetails, extra: itinerary.id);
      },
      child: Container(
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
                      colors: [Colors.black.withOpacity(0.5), Colors.transparent, Colors.black.withOpacity(0.7)],
                      begin: const FractionalOffset(0, 0),
                      end: const FractionalOffset(0, 1),
                      stops: const [0.0, 0.5, 1.0],
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
                      Text(
                        "${itinerary.startDate.dateString} - ${itinerary.endDate.dateString}",
                        style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconRowWidget(
                            icon: CupertinoIcons.location_solid,
                            text: "${itinerary.locations.length} locations",
                          ),
                          IconRowWidget(
                            icon: CupertinoIcons.group_solid,
                            text: "${itinerary.travelers.length} travellers",
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 110,
                        child: TertiaryButton(
                          text: 'More >',
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
      ),
    );
  }
}

class IconRowWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconRowWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
