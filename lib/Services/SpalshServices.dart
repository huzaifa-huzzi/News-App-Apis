 import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app_api/Routes/Routesname.dart';


class Services {

  void isLogin(BuildContext context){
    Timer(const Duration(seconds: 4), () {
       Navigator.pushNamed(context, RoutesName.homeScreen);
    });
  }


}