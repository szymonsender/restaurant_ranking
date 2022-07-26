import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class RestaurantPage extends StatelessWidget {
  const RestaurantPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('restaruants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Coś poszło nie tak'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Ładowanie'));
          }

          final documents = snapshot.data!.docs;
          return ListView(
            children:  [
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(document['name']),
                          const SizedBox(height: 5,),
                          Text(document['city']),
                        ],
                      ),
                      
                      Text(document['rating'].toString()),
                    ],
                  ),
                ),
              ], 
              
            ],
          );
        });
  }
}