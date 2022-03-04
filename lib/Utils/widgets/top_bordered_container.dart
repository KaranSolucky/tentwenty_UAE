import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tentwenty/Utils/widgets/tag_container.dart';
import 'package:tentwenty/constants/constants.dart';
import 'package:tentwenty/modal_class/movie.dart';

class TopBorderedContainer extends StatelessWidget {
  const TopBorderedContainer({
    Key? key,
    required this.movie,
    this.child,
  }) : super(key: key);

  final Movie? movie;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeIcon = size.height * .035;

    final textStyle = GoogleFonts.barlowCondensed(
      fontSize: sizeIcon * .75,
      fontWeight: FontWeight.w500,
    );
    return Container(
      width: double.infinity,
      height: size.height * .11,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 40,
          )
        ],
        color: kPrimaryColor,
      ),
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite,
                    size: sizeIcon,
                    color: Colors.white60,
                  ),
                  Text(
                    movie!.voteCount.toString(),
                    style: textStyle,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TagContainer(
                    tag: '  IDMB  ',
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.orangeAccent],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    movie!.voteCount.toString(),
                    style: textStyle,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: sizeIcon,
                    color: Colors.white60,
                  ),
                  Text(
                    movie!.voteCount.toString(),
                    style: textStyle,
                  ),
                ],
              )
            ],
          ),
    );
  }
}
