import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/Models/Categories_news_Model.dart';
import 'package:news_app_api/view/HomeScree/Homescreen.dart';
import 'package:news_app_api/view_model/news_View_model.dart';



class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat( 'MMMM dd,yyyy');
  String categoryName = 'General';

  List<String> categoriesList =[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories',style: GoogleFonts.poppins(fontSize:24,fontWeight:FontWeight.bold,),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoriesList.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      categoryName = categoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding:const  EdgeInsets.only(right: 12),
                      child: Container(
                        decoration:  BoxDecoration(
                          color:categoryName == categoriesList[index] ? Colors.blue : Colors.grey,
                          borderRadius:BorderRadius.circular(20)
                        ),
                        child: Padding(
                            padding:const  EdgeInsets.symmetric(horizontal: 12),
                            child: Center(child: Text(categoriesList[index].toString(),style: GoogleFonts.poppins(
                              fontSize:13,
                              color:Colors.white,
                            ),))),
                      ),
                    ),
                  );
                }

            ),
          ),
         SizedBox(
           height: height * 0.03,
         ),
          Expanded(
            child: FutureBuilder<CategoriesNewsModel>(future:newsViewModel.fetchCategoriesApi(categoryName), builder: (BuildContext context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const  Center(child: SpinKitChasingDots(color: Colors.blue,size: 40,),);
              }else{
                return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder:(context,index){
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return  Padding(
                        padding:const  EdgeInsets.only(bottom: 15,left: 5),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15) ,
                              child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),fit: BoxFit.cover,height: height  * .2,width: width * .5,placeholder: (context,url) => Container(child: Spinkit2,)  ,errorWidget: (context,url,error) => const Icon(Icons.error_outline,color: Colors.red,),),
                            ),
                            Expanded(child: Container(
                              height:  height * .18,
                              padding:const EdgeInsets.only(left:5),
                              child: Column(
                                children: [
                                   Text(snapshot.data!.articles![index].title.toString(),maxLines: 3,style: GoogleFonts.poppins(fontSize:15,color:Colors.black54,fontWeight:FontWeight.w700,),),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data!.articles![index].source!.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize:10,color:Colors.black54,fontWeight:FontWeight.w600),),
                                      Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize:8,fontWeight:FontWeight.w500),),
                                    ],
                                  )
                                ],
                              ),
                            ))
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
