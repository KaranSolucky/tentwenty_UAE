import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwenty/Utils/widget/tween_animations.dart';
import 'package:tentwenty/Utils/widgets/tag_container.dart';
import 'package:tentwenty/screens/ticket/widgets/ticket_page_widgets.dart';

import '../../constants/constants.dart';
import '../../modal_class/movie.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key, this.movie}) : super(key: key);

  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    final hideWidgets = ValueNotifier(false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColorDark,
      body: ValueListenableBuilder(
        valueListenable: hideWidgets,
        builder: (context, dynamic value, child) {
          return AnimatedContainer(
              duration: kDuration400ms,
              padding: EdgeInsets.only(top: value ? 100 : 0),
              curve: Curves.fastOutSlowIn,
              child: child);
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 20,
              top: size.height * .07,
              child: TranslateAnimation(
                child: IconButton(
                  onPressed: () {
                    hideWidgets.value = true;
                    Navigator.pop(context);
                  },
                  iconSize: 30,
                  icon: const Icon(Icons.close),
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
                top: size.height * .14,
                left: 20,
                right: 20,
                child: TranslateAnimation(
                  child: Container(
                      height: size.height * .7,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const TicketDateWidget(),
                            const SizedBox(height: 40),
                            Text(
                              movie!.title!.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.barlowCondensed(
                                color: kPrimaryColorDark,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0,
                                fontSize: size.height * .04,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Wrap(
                              runSpacing: 10,
                              children:
                                  List.generate(movie!.title!.length, (i) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TagContainer(
                                    tag: movie!.id.toString(),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const _TileInfo(
                                    title: 'Cinema',
                                    subtitle: 'PVR CINEMAS',
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start),
                                _TileInfo(
                                  title: 'Start time',
                                  subtitle: movie!.id.toString(),
                                ),
                                _TileInfo(
                                    title: 'Duration',
                                    subtitle: '${movie!.id.toString()} min',
                                    crossAxisAlignment: CrossAxisAlignment.end),
                              ],
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                    children: List.generate(50, (i) {
                                  return const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Divider(
                                              color: kPrimaryColorDark,
                                              thickness: 2)));
                                }))),
                          ])),
                )),
          ],
        ),
      ),
    );
  }
}

class _TileInfo extends StatelessWidget {
  const _TileInfo({
    Key? key,
    this.title,
    this.subtitle,
    this.crossAxisAlignment,
  }) : super(key: key);
  final String? title;
  final String? subtitle;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title!,
          style: GoogleFonts.barlowCondensed(
            fontWeight: FontWeight.w500,
            color: kPrimaryColorDark,
            fontSize: size.height * .02,
          ),
        ),
        Text(
          subtitle!,
          style: GoogleFonts.barlowCondensed(
            color: kPrimaryColorLight,
            height: 1.5,
            fontWeight: FontWeight.w500,
            fontSize: size.height * .02,
          ),
        ),
      ],
    );
  }
}
