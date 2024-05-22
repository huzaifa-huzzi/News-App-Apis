import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_api/Models/Categories_news_Model.dart';
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
  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlinesApi(String channelName) async {
    String url = 'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=1e13388ef39a450ea8c6ea9a5fe635a6';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception('Failed to load headlines');
  }
  Future<CategoriesNewsModel> fetchCategoriesApi(String general) async {
    String url = 'https://newsapi.org/v2/everything?q=${general}&apiKey=1e13388ef39a450ea8c6ea9a5fe635a6';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Failed to load headlines');
  }




 }