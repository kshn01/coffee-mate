import 'package:flutter/material.dart';
import 'package:coffee_crew/models/coffee.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({Key? key, this.coffee}) : super(key: key);

  final Coffee? coffee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
      ),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[coffee!.strength ?? 0],
          ),
          title: Text(coffee!.name ?? ""),
          subtitle: Text("Takes ${coffee!.sugars} sugar(s)"),
        ),
      ),
    );
  }
}
