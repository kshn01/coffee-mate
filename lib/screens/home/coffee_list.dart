import 'package:coffee_crew/models/coffee.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'coffee_card.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({Key? key}) : super(key: key);

  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  late NativeAd _ad;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNativeAd();
  }

  void loadNativeAd() {
    _ad = NativeAd(
      request: AdRequest(),
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'listTile',
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          setState(() {
            isLoaded = true;
          });
          print('$ad loaded. ♦');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('$ad failed to load: $error ♦');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('$ad opened.♦'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('$ad closed.♦'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('$ad impression.♦'),
        // Called when a click is recorded for a NativeAd.
        onNativeAdClicked: (NativeAd ad) => print('$ad clicked. ♦'),
      ),
    )..load();

    // _ad.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ad.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coffees = Provider.of<List<Coffee>?>(context) ?? [];

    // coffees!.forEach((element) {
    //   print(element.name);
    //   print(element.sugars);
    //   print(element.strength);
    // });

    return ListView.builder(
        padding: EdgeInsets.only(
          bottom: 8,
        ),
        itemBuilder: (context, index) {
          if (isLoaded && index == 2) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: Container(
                      child: AdWidget(ad: _ad),
                      alignment: Alignment.center,
                      height: 180,
                      color: Colors.black12,
                    ),
                  ),
                ),
                CoffeeCard(
                  coffee: coffees[index],
                ),
              ],
            );
          } else {
            return CoffeeCard(coffee: coffees[index]);
          }
        },
        itemCount: coffees.length);
  }
}
