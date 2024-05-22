import 'package:news_app_api/Models/Categories_news_Model.dart';
import 'package:news_app_api/Models/news_Chaneels_haedline_Model.dart';
import 'package:news_app_api/Repository/news_repository.dart';

class NewsViewModel{
  final _repo =NewsRepository();
     // Axis Rotation :horizontal .....HomeScreen
  Future<NewsChannelHeadlineModel>fetchNewsChannelHeadlinesApi()async{
     final response =await _repo.fetchNewsChannelHeadlinesApi();
     return response;
  }
   //Applying Filter in Home screen
  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlinesApi(String channelName) async {
    final response = await _repo.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }
  //For Categories Screen
  Future<CategoriesNewsModel> fetchCategoriesApi(String general) async {
    final response = await _repo.fetchCategoriesApi(general);
    return response;
  }


}