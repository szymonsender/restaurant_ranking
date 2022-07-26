import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_ranking/app/home/add_opinion/add_opinion_page.dart';
import 'package:restaurant_ranking/app/home/my_account/my_account_page.dart';
import 'package:restaurant_ranking/app/home/restaurants/restaurants_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ranking restauracji',
        ),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const RestaurantPage();
        }
        if (currentIndex == 1) {
          return AddOpinionPage(
            onSave: () {
              setState(() {
                currentIndex = 0;
              });
            },
          );
        }

        return MyAccountPage(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Opinie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
        ],
      ),
    );
  }
}
