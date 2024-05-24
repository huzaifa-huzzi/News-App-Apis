import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class DetailScreen extends StatefulWidget {
 final  String newImage,newsTitle,newsData,author,description,content,source;
  const DetailScreen({super.key,
   required this.newImage,
   required this.author,
   required this.content,
   required this.description,
   required this.newsData,
   required this.newsTitle,
    required this.source,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  final format = DateFormat( 'MMMM dd,yyyy');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).height * 1;
    final height = MediaQuery.sizeOf(context).width * 1;

    DateTime dateTime = DateTime.parse(widget.newsData);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
         children: [
           Container(
             child: Container(
               height: height * .5,
               child: ClipRRect(
                   borderRadius:const  BorderRadius.only(
                     topLeft: Radius.circular(20),
                     bottomRight: Radius.circular(40),
                   ),
                   child: CachedNetworkImage(imageUrl: widget.newImage,fit: BoxFit.cover,placeholder: (context,url) =>const  Center(child:CircularProgressIndicator(color: Colors.blue,) ,),)),
             ),
           ),
           Container(
             height: height * .6,
             margin: EdgeInsets.only(top: height * .4),
             padding:const  EdgeInsets.only(top: 20,right: 20,left: 20),
             decoration:const  BoxDecoration(
               color: Colors.white,
               borderRadius:  BorderRadius.only(
                 topLeft: Radius.circular(20),
                 bottomRight: Radius.circular(40),
               ),
             ),
             child: ListView(
               children: [
                   Text(widget.newsTitle,style: GoogleFonts.poppins(fontSize:20,color:Colors.black87,fontWeight:FontWeight.w700),),
                 SizedBox(height:  height * .02,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                   Text(widget.source,style: GoogleFonts.poppins(fontSize:13,color:Colors.black87,fontWeight:FontWeight.w600)),
                   Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize:12,color:Colors.black87,fontWeight:FontWeight.w500)),
                     ],),
                 SizedBox(height:  height * .02,),
                 Column(
                   children: [
                     Text(widget.description,style: GoogleFonts.poppins(fontSize:15,color:Colors.black87,fontWeight:FontWeight.w500)),
                   ],
                 )
               ],
             ),
           )
         ],
      ),
    );
  }
}
