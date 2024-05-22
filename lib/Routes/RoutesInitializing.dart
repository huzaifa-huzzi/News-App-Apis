import 'package:flutter/material.dart';
import 'package:news_app_api/Routes/Routesname.dart';
import 'package:news_app_api/view/Categories/Categories%20_Screen.dart';
import 'package:news_app_api/view/HomeScree/Homescreen.dart';
import 'package:news_app_api/view/splash%20Screen/SplashScreen.dart';

class Routes{

  static Route<dynamic>generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splashscreen :
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RoutesName.homeScreen :
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case RoutesName.categoriesScreen :
        return MaterialPageRoute(builder: (context) => const CategoriesScreen());



      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No Route Find'),
            ),
          );
        },
        );
    }
  }
}