import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // To get the collection reference
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // coffee list from snapshot

  List<Coffee> _coffeeListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Coffee(name: doc.get('name') ,
      strength: doc.get('strength') ,
      sugars: doc.get('sugars'));
    }).toList();
  }


  // get bruce stream

  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapShot);
  }
}
