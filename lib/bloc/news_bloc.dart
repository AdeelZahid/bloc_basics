import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:bloc_beginner/model/newsInfo.dart';
import 'package:bloc_beginner/constants/strings.dart';

enum NewsAction { fetch, delete }

class NewsBloc {
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.fetch) {
        try {
          var news = await getNews();

          if (news != null) {
            _newsSink.add(news.articles);
          } else {
            _newsSink.addError('Something Went wrong');
          }
        } on Exception catch (e) {
          print(e.hashCode);
          _newsSink.addError('Something Went wrong');
        }
      } else {
        return 0;
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      // http.Response response = await client.get(
      //     'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=256cc8a1c2c04a75a5fe8743cebfdc13');
      http.Response response = await client.get(Strings.news_url);
      print('RESPONSE: ${response.body}');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }
    return newsModel;
  }

  void newsBlocDispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
