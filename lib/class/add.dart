import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppAds {
  static bannerAds(BuildContext context) {
    return Builder(builder: (ctx) {
      final BannerAd myBanner = BannerAd(
        adUnitId: 'ca-app-pub-2390283648539425/5986334902',
        request: const AdRequest(),
        listener: const BannerAdListener(),
        size: AdSize.largeBanner,
      );
      myBanner.load();
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: myBanner.size.height.toDouble(),
        child: AdWidget(
          ad: myBanner,
          key: Key(myBanner.hashCode.toString()),
        ),
      );
    });
  }
}
