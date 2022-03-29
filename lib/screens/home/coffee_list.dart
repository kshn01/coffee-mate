import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'coffee_card.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({Key? key}) : super(key: key);

  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>>(context);


    // coffees!.forEach((element) {
    //   print(element.name);
    //   print(element.sugars);
    //   print(element.strength);
    // });

    return ListView.builder(
      itemBuilder: (context, index) {
        return CoffeeCard(coffee:coffees[index]);
      },
      itemCount: coffees.length ,
    );
  }
}
