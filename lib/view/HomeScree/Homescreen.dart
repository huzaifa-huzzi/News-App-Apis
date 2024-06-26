import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/Models/Categories_news_Model.dart';
import 'package:news_app_api/Models/news_Chaneels_haedline_Model.dart';
import 'package:news_app_api/Routes/Routesname.dart';
import 'package:news_app_api/view/Detail%20Screen/Detail_Screen.dart';
import 'package:news_app_api/view_model/news_View_model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 enum FilterList {bbcNews,aryNews,independent,cnn,alJazeera}
class _HomeScreenState extends State<HomeScreen> {


  NewsViewModel newsViewModel = NewsViewModel();
          FilterList? selectedMenu;
          final format = DateFormat( 'MMMM dd,yyyy');
          String name = 'bbc-news';



  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).height * 1;
    final height = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('News',style: GoogleFonts.poppins(fontSize:24,fontWeight:FontWeight.bold,),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pushNamed(context, RoutesName.categoriesScreen);
        }, icon:Image.asset('images/category_icon.png',height: 30,width: 30,)),
        actions: [

        PopupMenuButton<FilterList>(
        initialValue: selectedMenu,
        icon:const  Icon(Icons.more_vert_outlined,color: Colors.black,),
          onSelected: (FilterList item) {
            String selectedName = '';
            if (item == FilterList.bbcNews) {
              selectedName = 'bbc-news';
            } else if (item == FilterList.aryNews) {
              selectedName = 'ary-news';
            } else if (item == FilterList.independent) {
              selectedName = 'independent-news';
            } else if (item == FilterList.cnn) {
              selectedName = 'cnn-news';
            } else if (item == FilterList.alJazeera) {
              selectedName = 'al-jazeera-english';
            }
            setState(() {
              selectedMenu = item;
              name = selectedName;
            });
          },
        itemBuilder:
            (context) =>
        <PopupMenuEntry<FilterList>>[
          const PopupMenuItem(
              value: FilterList.bbcNews,
              child: Text('BBC News')


          ),
          const PopupMenuItem(
              value: FilterList.aryNews,
              child: Text('Ary News')


          ),
          const PopupMenuItem(
              value: FilterList.independent,
              child: Text('Independent News')


          ),
         const  PopupMenuItem(
              value: FilterList.cnn,
              child: Text('CNN News')


          ),
          const PopupMenuItem(
              value: FilterList.alJazeera,
              child: Text('Al-Jazeera-english News')


          )
        ],
      ),
    ]
    ),


      body:  ListView(
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
                              return  InkWell(
                                 onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    DetailScreen(
                                        newImage:snapshot.data!.articles![index].urlToImage.toString() ,
                                        author: snapshot.data!.articles![index].author.toString(),
                                        content:snapshot.data!.articles![index].content.toString(),
                                        description: snapshot.data!.articles![index].description.toString(),
                                        newsData: snapshot.data!.articles![index].publishedAt.toString(),
                                        newsTitle: snapshot.data!.articles![index].title.toString(),
                                        source: snapshot.data!.articles![index].source!.name.toString())
                                  ));
                                 },
                                child: SizedBox(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height:height * 0.8,
                                          width: width *.5,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: height * .04,
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
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.4,
                                                    child: Text(snapshot.data!.articles![index].title.toString(),maxLines: 3,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize:17,fontWeight:FontWeight.w700),),
                                                  ),
                                                  SizedBox(height: height * .09,),
                                                  Container(
                                                    width: width * 0.4,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(snapshot.data!.articles![index].source!.name.toString(),maxLines: 2,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.w600,color:Colors.blue),),
                                                        Text(format.format(dateTime),maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize:12,fontWeight:FontWeight.w500),),
                                                      ],
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              );
                            }
        
                        );
                      }
                   }),
                 ),
            SizedBox(height: height * .03,),
            FutureBuilder<CategoriesNewsModel>(future:newsViewModel.fetchCategoriesApi('General'), builder: (BuildContext context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const  Center(child: SpinKitChasingDots(color: Colors.blue,size: 40,),);
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      shrinkWrap: true,
                      physics:const  NeverScrollableScrollPhysics(),
                      itemBuilder:(context,index){
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return  Padding(
                          padding:const  EdgeInsets.only(bottom: 10,left: 2),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15) ,
                                child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),fit: BoxFit.cover,height: height  * .3,width: width * .2,placeholder: (context,url) => Container(child: Spinkit2,)  ,errorWidget: (context,url,error) => const Icon(Icons.error_outline,color: Colors.red,),),
                              ),
                              Expanded(child: Container(
                                height:  height * .18,
                                padding:const EdgeInsets.only(left:5),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.articles![index].title.toString(),maxLines: 2,style: GoogleFonts.poppins(fontSize:13,color:Colors.black54,fontWeight:FontWeight.w700,),),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.articles![index].source!.name.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize:10,color:Colors.black54,fontWeight:FontWeight.w600),),
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
        
          ],
        ),
    );
  }
}


const  Spinkit2 = SpinKitFadingCircle(
    color: Colors.blue,
  size: 50,
);