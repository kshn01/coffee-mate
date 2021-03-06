import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_crew/screens/home/settings_form.dart';
import 'package:coffee_crew/services/ad_state.dart';
import 'package:coffee_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:coffee_crew/services/databases.dart';
import 'package:coffee_crew/screens/home/coffee_list.dart';
import 'package:coffee_crew/models/coffee.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          size: AdSize.banner,
          adUnitId: adState.bannerAdUnitId,
          request: AdRequest(),
          listener: adState.adlistener,
        )..load();


      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // to create a bottom settings panel to update change
    void _showSettingsPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Coffee>?>.value(
      value: DatabaseService().coffee,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text("Coffee Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.white70,
              ),
              onPressed: () {
                _showSettingsPanel();
              },
              icon: const Icon(Icons.settings),
              label: const Text(""),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.white70,
              ),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text(""),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: CoffeeList(),
            ),
            if (banner == null)
              SizedBox(height: 50)
            else
              Container(
                height: 50,
                child: AdWidget(
                  ad: banner!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
