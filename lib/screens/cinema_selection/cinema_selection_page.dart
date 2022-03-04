import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwenty/Utils/widget/tween_animations.dart';
import 'package:tentwenty/Utils/widgets/tag_container.dart';
import 'package:tentwenty/Utils/widgets/top_bordered_container.dart';

import '../../Utils/widget/hours_movie_list.dart';
import '../../Utils/widgets/gradient_animation_button.dart';
import '../../constants/api_constants.dart';
import '../../constants/constants.dart';
import '../../modal_class/movie.dart';
import '../seatselection/seats_selection_page.dart';
import 'widgets/select_cinema.dart';

class CinemaSelectionPage extends StatelessWidget {
  const CinemaSelectionPage({Key? key, this.movie}) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    final hideWidgets = ValueNotifier(false);
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      body: ValueListenableBuilder(
          valueListenable: hideWidgets,
          builder: (context, dynamic value, child) {
            return AnimatedContainer(
              duration: kDuration400ms,
              margin: EdgeInsets.only(top: value ? 100 : 0),
              curve: Curves.fastOutSlowIn,
              child: child,
            );
          },
          child: _BodyCinemaSelection(movie: movie, hideWidgets: hideWidgets)),
    );
  }
}

class _BodyCinemaSelection extends StatelessWidget {
  const _BodyCinemaSelection({
    Key? key,
    required this.movie,
    required this.hideWidgets,
  }) : super(key: key);

  final Movie? movie;
  final ValueNotifier<bool> hideWidgets;

  @override
  Widget build(BuildContext context) {
    final selectedHourNotifier = ValueNotifier(-1);
    final listHours = [
      '07:00',
      '09:15',
      '12:00',
      '15:30',
      '17:45',
      '19:00',
      '21:25'
    ];
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        ScaleAnimation(
          initScale: .95,
          child:
              Image.network(TMDB_BASE_IMAGE_URL + 'w500/' + movie!.posterPath!),
        ),
        TranslateAnimation(
          duration: const Duration(milliseconds: 400),
          child: Container(
            padding: EdgeInsets.only(top: size.height * .20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPrimaryColorDark.withOpacity(.1),
                  kPrimaryColorDark.withOpacity(.6),
                  kPrimaryColorDark.withOpacity(.7),
                  kPrimaryColorDark,
                ],
                stops: const [0.1, 0.3, 0.38, 0.55],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                TranslateAnimation(
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      movie!.title!.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.barlowCondensed(
                          fontSize: size.height * .04,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TranslateAnimation(
                  duration: const Duration(milliseconds: 600),
                  child: TopBorderedContainer(
                    movie: movie,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Today",
                          style: GoogleFonts.barlowCondensed(
                            fontSize: size.height * .03,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const TagContainer(tag: 'PREMIERE'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const TranslateAnimation(
                    duration: Duration(milliseconds: 700),
                    child: SelectCinema()),
                const SizedBox(height: 30),
                TranslateAnimation(
                  child: SizedBox(
                    height: size.height * .22,
                    child: HoursMovieOptions(
                        listHours: listHours,
                        selectedHourNotifier: selectedHourNotifier,
                        movie: movie),
                  ),
                ),
              ],
            ),
          ),
        ),
        GradientAnimationButton(
          hideWidgets: hideWidgets,
          onPressed: () {
            _openChooseSeats(context, movie);
          },
          label: 'SELECT TIME',
        ),
        Positioned(
            top: 25,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
      ],
    );
  }

  void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _openChooseSeats(BuildContext context, Movie? movie) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: kDuration400ms,
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: SeatsSelectionPage(movie: movie),
            );
          },
        ));
  }
}
