import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/constants.dart';
import 'package:final_project/screens/movie_screen.dart';
import 'package:flutter/material.dart';

class FeaturedMovies extends StatelessWidget {
  const FeaturedMovies({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieScreen(movie: snapshot.data[itemIndex])));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}'),
                ),
              ),
            );
          }),
    );
  }
}
