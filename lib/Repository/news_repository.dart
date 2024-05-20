import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_api/Models/news_Chaneels_haedline_Model.dart';
 class NewsRepository{

  Future<NewsChannelHeadlineModel>fetchNewsChannelHeadlinesApi()async{
       String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=1e13388ef39a450ea8c6ea9a5fe635a6';

       final response =await http.get(Uri.parse(url));

       if(response.statusCode == 200){
         final body = jsonDecode(response.body);
       return NewsChannelHeadlineModel.fromJson(body);
       }else{
         throw Exception('Error');
       }
  }



 }