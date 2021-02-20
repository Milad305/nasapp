
import 'package:flutter/material.dart';
import 'package:nasboard/src/pages/mainPage.dart';
import 'package:nasboard/src/pages/Profile.dart';
import 'package:nasboard/src/pages/likedproducts.dart';
import 'package:nasboard/src/pages/signin.dart';
import 'package:nasboard/src/pages/signup.dart';
import 'package:nasboard/src/pages/paymentpage.dart';
import 'package:nasboard/src/pages/productlistpage.dart';
class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      MainPage.routeName: (_) => MainPage(),
      SignUpScreen.routeName:(_) => SignUpScreen(),
      SignInPage.routeName:(_) => SignInPage(),
      LikedProductPage.routeName:(_) =>LikedProductPage(),
      ProfilePage.routeName:(_) => ProfilePage(),
      Payment.routeName:(_) => Payment(),
      ProductGrid.routeName:(_) => ProductGrid(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}