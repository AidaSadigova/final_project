import 'package:final_project/screens/homepage.dart';
import 'package:final_project/screens/mainpage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Padding(
          padding: EdgeInsets.only(left: 80),
          child: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          const Center(
              child: CircleAvatar(
            backgroundImage: AssetImage('lib/images/yellowgirl.jpg'),
            radius: 40,
          )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Ariane Grande',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 204, 18, 4),
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              minimumSize: const Size(300, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Sign out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
