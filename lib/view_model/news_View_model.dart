import 'package:news_app_api/Models/news_Chaneels_haedline_Model.dart';
import 'package:news_app_api/Repository/news_repository.dart';

class NewsViewModel{
  final _repo =NewsRepository();

  Future<NewsChannelHeadlineModel>fetchNewsChannelHeadlinesApi()async{
     final response =await _repo.fetchNewsChannelHeadlinesApi();
     return response;
  }
  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlinesApi(String channelName) async{
    final response = await _repo.fetchNewChannelHeadlinesApi(channelName);
    return response ;
  }

}