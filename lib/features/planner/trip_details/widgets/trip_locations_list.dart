import 'package:cinnamon_riverpod_2/helpers/helper_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cinnamon_riverpod_2/infra/planner/model/trip_location.dart';

class TripLocationsList extends StatelessWidget {
  final List<TripLocation> tripLocations;
  final Function(TripLocation location) onTapLocation;
  final TripLocation? selectedLocation;
  final bool isEnabled;

  const TripLocationsList({
    Key? key,
    required this.tripLocations,
    required this.onTapLocation,
    this.selectedLocation,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tripLocations.length,
      itemBuilder: (_, index) {
        final location = tripLocations[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Material(
            color: context.theme.scaffoldBackgroundColor,
            child: ListTile(
              selected: selectedLocation?.id == location.id,
              leading: Text((index + 1).toString(), style: context.theme.textTheme.labelSmall),
              title: Row(
                children: [
                  Text(location.name, style: context.theme.textTheme.labelSmall),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '(${location.duration.inMinutes} min)',
                    style: context.theme.textTheme.bodySmall,
                  ),
                ],
              ),
              trailing: location.isVisited ? const Icon(CupertinoIcons.check_mark_circled) : null,
              onTap: () => onTapLocation(location),
              enabled: isEnabled,
            ),
          ),
        );
      },
    );
  }
}
