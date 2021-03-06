import 'dart:io' show Platform;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId =>
      Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : '';


  // actual ad id : ca-app-pub-4998761288616162/6403179099
  // test ad : ca-app-pub-3940256099942544/6300978111

  BannerAdListener get adlistener => _adlistener;

  BannerAdListener _adlistener = BannerAdListener(
  // Called when an ad is successfully received.
  onAdLoaded: (Ad ad) => print('Ad loaded.'),
  // Called when an ad request failed.
  onAdFailedToLoad: (Ad ad, LoadAdError error) {
  // Dispose the ad here to free resources.
  ad.dispose();
  print('Ad failed to load: $error');
  },
  // Called when an ad opens an overlay that covers the screen.
  onAdOpened: (Ad ad) => print('Ad opened.'),
  // Called when an ad removes an overlay that covers the screen.
  onAdClosed: (Ad ad) => print('Ad closed.'),
  // Called when an impression occurs on the ad.
  onAdImpression: (Ad ad) => print('Ad impression.'),
  );

}
