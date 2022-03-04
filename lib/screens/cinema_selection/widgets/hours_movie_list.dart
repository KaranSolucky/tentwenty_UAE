import 'package:flutter/material.dart';

import '../../../Utils/widget/hour_container.dart';
import '../../../modal_class/movie.dart';

class HoursMovieOptions extends StatelessWidget {
  const HoursMovieOptions({
    Key? key,
    required this.listHours,
    required this.selectedHourNotifier,
    required this.movie,
  }) : super(key: key);

  final List<String> listHours;
  final ValueNotifier<int> selectedHourNotifier;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 2 / 4,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: List.generate(listHours.length, (i) {
        return HourContainer(
          hour: listHours[i],
          selectedHourNotifier: selectedHourNotifier,
          onTap: () => movie!.releaseDate = listHours[i],
          id: i,
        );
      }),
    );
  }
}
