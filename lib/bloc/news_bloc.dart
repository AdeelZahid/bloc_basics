import 'dart:async';
import 'package:bloc_beginner/services/api_manager.dart';
import 'package:bloc_beginner/model/newsInfo.dart';

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
        API_Manager apiManager = API_Manager();
        try {
          var news = await apiManager.getNews();

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

  void newsBlocDispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
