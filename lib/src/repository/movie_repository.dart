//import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_tmdb/src/models/movie.dart';
//import 'package:movie_api_sample/src/model/movie.dart';

class MovieRepository {
  late var _dio;
  MovieRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.themoviedb.org",
        queryParameters: {
          'api_key': '05a0a3edace90f16f541226fc3287797',
        },
      ),
    );
  }
  Future<List<Map<String, dynamic>>> loadGenre() async {
    var response = await _dio.get('/3/genre/movie/list');
    if (response.data != null) {
      var data = response.data['genres'] as List;
      // 모델을 만들면 아래 부분은 fromJson 으로 처리
      return data.map((genre) => genre as Map<String, dynamic>).toList();// 19:20초 근처
    } else {
      return [];
    }
  }

  Future<List<Movie>> loadMovieListWithGenre(int activeGenreId) async {
    var response = await _dio.get('/3/discover/movie',
        queryParameters: {'with_genres': activeGenreId});
    if (response.data != null && response.data['results'] != null) {
      var data = response.data['results'] as List;
      return data.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      return [];
    }
  }
}