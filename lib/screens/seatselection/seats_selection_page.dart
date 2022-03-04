import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tentwenty/Utils/widget/tween_animations.dart';
import 'package:tentwenty/Utils/widgets/gradient_animation_button.dart';
import 'package:tentwenty/modal_class/seats.dart';
import 'package:tentwenty/screens/summary/summary_page.dart';

import '../../constants/constants.dart';
import '../../modal_class/movie.dart';
import 'widgets/seats_selection_widgets.dart';

class SeatsSelectionPage extends StatelessWidget {
  const SeatsSelectionPage({Key? key, this.movie}) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    final hideWidgets = ValueNotifier(false);
    final seatsSelectedNotifier = ValueNotifier(0);

    return Scaffold(
        backgroundColor: kPrimaryColorDark,
        body: ValueListenableBuilder(
          valueListenable: hideWidgets,
          builder: (context, dynamic value, child) {
            return AnimatedContainer(
              duration: kDuration400ms,
              curve: Curves.fastOutSlowIn,
              margin: EdgeInsets.only(top: value ? 100 : 0),
              child: child,
            );
          },
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 20, bottom: 30, top: 10),
                      child: CustomAppBar(
                        title: movie!.title,
                        subtitle: 'Today ${movie!.title}',
                        onPressedBack: () {
                          hideWidgets.value = true;
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  TranslateAnimation(
                    duration: const Duration(milliseconds: 600),
                    child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TypeSeatInfo(
                                color: Color(0xFFB0BEC5),
                                quantity: 8,
                                label: 'Empty',
                              ),
                              const TypeSeatInfo(
                                color: kPrimaryColor,
                                quantity: 38,
                                label: 'Bought',
                              ),
                              ValueListenableBuilder<int>(
                                  valueListenable: seatsSelectedNotifier,
                                  builder: (context, value, _) {
                                    return TypeSeatInfo(
                                      color: kAccentColor,
                                      quantity: value,
                                      label: 'Selected',
                                    );
                                  }),
                            ])),
                  ),
                  const SizedBox(height: 100),
                  TranslateAnimation(
                    duration: const Duration(milliseconds: 700),
                    child: Column(
                      children:
                          List.generate(SeatsRowData.seatsList.length, (i) {
                        return RowSeats(
                          seatsSelectedNotifier: seatsSelectedNotifier,
                          numSeats: SeatsRowData.seatsList[i].seats,
                          seatsOccupied:
                              SeatsRowData.seatsList[i].occupiedSeats,
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TranslateAnimation(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          SeatsRowData.firstSeatsList.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RowSeats(
                            numSeats: SeatsRowData.firstSeatsList[i].seats,
                            seatsOccupied:
                                SeatsRowData.firstSeatsList[i].occupiedSeats,
                            seatsSelectedNotifier: seatsSelectedNotifier,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              GradientAnimationButton(
                hideWidgets: hideWidgets,
                onPressed: () {
                  _openSummary(context, movie);
                },
                label: 'SELECT SEATS',
              ),
            ],
          ),
        ));
  }

  void _openSummary(BuildContext context, Movie? movie) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: kDuration400ms,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: SummaryPage(movie: movie),
            );
          },
        ));
  }
}
