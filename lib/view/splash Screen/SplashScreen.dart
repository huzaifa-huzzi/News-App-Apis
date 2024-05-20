import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_api/Services/SpalshServices.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
          Services splash = Services();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child:Center(
          child: Column(
            children: [
              Image.asset('images/splash_pic.jpg',fit: BoxFit.cover ,height: height * .8,),
              SizedBox(height: height * 0.04,),
              Text('Top Headlines',style:GoogleFonts.anton(letterSpacing:.6,color:Colors.grey.shade700) ,),
              SizedBox(height: height * 0.04,),
               const SpinKitChasingDots(
                color: Colors.blue,
                size: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
