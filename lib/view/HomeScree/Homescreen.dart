import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/Models/news_Chaneels_haedline_Model.dart';
import 'package:news_app_api/view_model/news_View_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

    final format = DateFormat( 'MMMM dd,YYYY');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).height * 1;
    final height = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('News',style: GoogleFonts.poppins(fontSize:24,fontWeight:FontWeight.bold,),),
        centerTitle: true,
        leading: IconButton(onPressed: (){}, icon:Image.asset('images/category_icon.png',height: 30,width: 30,)),
      ),
      body: ListView(
        children: [
             SizedBox(
                 height: height * .70,
                 width: width * .70,
                 child: FutureBuilder<NewsChannelHeadlineModel>(future:newsViewModel.fetchNewsChannelHeadlinesApi(), builder: (BuildContext context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const  Center(child: SpinKitChasingDots(color: Colors.blue,size: 40,),);
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context,index){

                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return  SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height:height * 0.6,
                                      width: width *.9,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: height * .02,
                                      ),
                                      child:ClipRRect(
                                        borderRadius: BorderRadius.circular(15) ,
                                      child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),fit: BoxFit.cover,placeholder: (context,url) => Container(child: Spinkit2,)  ,errorWidget: (context,url,error) => const Icon(Icons.error_outline,color: Colors.red,),),
                                    ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          padding:const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: width * 0.7,
                                                child: Text(snapshot.data!.articles![index].title.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize:17,fontWeight:FontWeight.w700),),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                          }

                      );
                    }
                 }),
               ),

        ],
      ),
    );
  }
}


const  Spinkit2 = SpinKitFadingCircle(
    color: Colors.blue,
  size: 50,
);