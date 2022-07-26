import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPage extends StatefulWidget {
  const AddOpinionPage({
    Key? key,
    required this.onSave,
  }) : super(key: key);
  final Function onSave;

  @override
  State<AddOpinionPage> createState() => _AddOpinionPageState();
}

class _AddOpinionPageState extends State<AddOpinionPage> {
  var restaurantName = '';
  var cityName = '';
  var rating = 2.5;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Podaj nazwę restauracji',
              ),
              onChanged: (newValue) {
                setState(() {
                  restaurantName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Podaj nazwę miasta',
              ),
              onChanged: (newValue) {
                setState(() {
                  cityName = newValue;
                });
              },
            ),
            Slider(
              onChanged: (newValue) {
                setState(() {
                  rating = newValue;
                });
              },
              value: rating,
              min: 0.0,
              max: 5.0,
              divisions: 10,
              label: rating.toString(),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: restaurantName.isEmpty || cityName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantName,
                        'city': cityName,
                        'rating': rating,
                      });
                      widget.onSave();
                    },
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
