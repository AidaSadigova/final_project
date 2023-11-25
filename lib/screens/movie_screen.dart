import 'package:final_project/constants.dart';
import 'package:final_project/models/movie.dart';
import 'package:final_project/screens/favorites_page.dart';
import 'package:final_project/screens/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key, required this.movie});
  final Movie movie;

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: 400,
            child: Image.network(
              '${Constants.imagePath}${widget.movie.backDropPath}',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                  Colors.black,
                  Colors.black
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 60),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                height: 250,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      widget.movie.title,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ReadMoreText(
                      widget.movie.overview,
                      style: GoogleFonts.aBeeZee(
                          fontSize: 15, color: Colors.white),
                      trimLines: 6,
                      colorClickableText: Colors.white70,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Read more',
                      trimExpandedText: 'Read less',
                      moreStyle:
                          GoogleFonts.aBeeZee(fontSize: 15, color: Colors.red),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]),
                          child: Center(
                            child: Text(
                              widget.movie.releaseDate,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 20,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              Text(
                                '${widget.movie.voteAverage.toStringAsFixed(1)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[800]),
                          child: Center(
                            child: Text(
                              widget.movie.originalLanguage,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              widget.movie.isFavorite =
                                  !widget.movie.isFavorite;
                            });
                          },
                          icon: const Icon(Icons.favorite),
                          color: widget.movie.isFavorite ? Colors.red : null,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 50, right: 50, bottom: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 204, 18, 4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                  builder: (context) => const FavoritesPage(
                        favorites: [],
                      )),
            );
          },
          child: Text('Your Favorite List',
              style: TextStyle(color: Colors.grey[200], fontSize: 25.0)),
        )),
      ),
    );
  }
}
