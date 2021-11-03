import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_movie_demo/home/model/home_model.dart';

class HomeRepository {
  Future<List<dynamic>> getData() async {
    var http = Dio();
    var url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=84ebd14770d7675041b532f1d88ce324&page=${Random().nextInt(100)}';
    HomeResponseModel model;
    var responses = await Future.wait([http.get(url)]);
    try {
      if (responses[0].statusCode == 200) {
        model = HomeResponseModel.fromJson(responses[0].data['results']);
      } else {
        throw HomeFailureModel('Error while fetching results');
      }
      return [model.list];
    } catch (e) {
      throw HomeFailureModel(e.toString());
    }
  }
}
