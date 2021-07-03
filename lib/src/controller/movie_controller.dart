import 'package:flutter/material.dart';
import 'package:flutter_tmdb/src/models/movie.dart';
import 'package:flutter_tmdb/src/repository/movie_repository.dart';

class MovieController extends ChangeNotifier {
  var _movieRepository = MovieRepository();
  var movies = <Movie>[];
  var activeGenreId = -1;
  var movieIndex = 0;


  Future<List<Map<String, dynamic>>> loadGenre() async {
    var genreList = await _movieRepository.loadGenre();
    if (genreList.isNotEmpty) {
      activeGenreId = genreList.first['id'].toInt();
      _loadMovieListWithGenre();
    }
//    print(genreList);
    return genreList;
  }

  void _loadMovieListWithGenre() async {
//    await Future.delayed(Duration(seconds: 2));
    movies = await _movieRepository.loadMovieListWithGenre(activeGenreId);
    notifyListeners();
  }

  void changeCategory(Map<String, dynamic> genre) {
    activeGenreId = genre["id"];
    notifyListeners();
    _loadMovieListWithGenre();
  }

}