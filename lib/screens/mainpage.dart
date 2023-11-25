import 'package:final_project/api/api.dart';
import 'package:final_project/models/movie.dart';
import 'package:final_project/screens/favorites_page.dart';
import 'package:final_project/screens/profile_page.dart';
import 'package:final_project/widgets/featured_movies.dart';
import 'package:final_project/widgets/movie_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('lib/images/yellowgirl.jpg'),
                    radius: 30,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '  Welcome Back',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Icon(
                            Icons.handshake,
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                      Text(
                        'Ariene Grande',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 204, 18, 4),
                      foregroundColor:
                          Colors.white, //Color.fromARGB(255, 87, 15, 10),
                      padding: EdgeInsets.zero, // Remove default padding
                      minimumSize: const Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.notifications),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    'Featured movies',
                    style:
                        GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: trendingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return FeaturedMovies(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    'Tv shows',
                    style:
                        GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Text(
                    'Upcoming movies',
                    style:
                        GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              SizedBox(
                child: FutureBuilder(
                    future: upcomingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieSlider(
                          snapshot: snapshot,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 60, right: 60, bottom: 20),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 204, 18, 4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                icon: const Icon(
                  Icons.home,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.play,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final favoriteMovies = await trendingMovies.then((Movie) =>
                      Movie.where((Movie) => Movie.isFavorite).toList());

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesPage(favorites: favoriteMovies),
                    ),
                  );
                },
                icon: const FaIcon(
                  FontAwesomeIcons.heart,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
