import 'package:final_project/models/movie.dart';
import 'package:final_project/screens/mainpage.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  final List<Movie> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Padding(
          padding: EdgeInsets.only(left: 80.0),
          child: Text(
            'Favorites',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.favorites.length,
        itemBuilder: (context, index) {
          final movies = widget.favorites[index];
          return Card(
            color: const Color.fromARGB(255, 196, 105, 99),
            child: ListTile(
              title: Center(
                child: Text(
                  movies.title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                color: const Color.fromARGB(255, 165, 41, 33),
                onPressed: () {
                  setState(() {
                    widget.favorites.remove(movies);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
