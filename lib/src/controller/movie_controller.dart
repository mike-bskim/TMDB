import 'package:flutter/material.dart';
import 'package:flutter_tmdb/src/models/movie.dart';
import 'package:flutter_tmdb/src/repository/movie_repository.dart';
import 'package:get/get.dart';

class MovieController extends GetxController {
  static MovieController get to => Get.find();

  var _movieRepository = MovieRepository();
  RxList<Movie> movies = <Movie>[].obs;
//  RxInt activeGenreId = (-1).obs;
  var activeGenreId = (-1);
  final Rx<Color> containerColor;// = Colors.white.obs;
  final Rx<Color> textColor;// = Colors.grey.obs;

  MovieController(this.containerColor, this.textColor); //  RxInt _movieIndex = 0.obs;


  void colorUpdate(Rx<Color> color1, Rx<Color> color2) {
    containerColor(color1 as Color);
    textColor(color2 as Color);
  }

  Future<List<Map<String, dynamic>>> loadGenre() async {
    var genreList = await _movieRepository.loadGenre();
    print('genreList: ${genreList.toString()}');
    if (genreList.isNotEmpty) {
      activeGenreId = genreList.first['id'].toInt();
      _loadMovieListWithGenre();
    }
//    print(genreList);
    return genreList;
  }

  void _loadMovieListWithGenre() async {
//    await Future.delayed(Duration(seconds: 2));
    movies.value = await _movieRepository.loadMovieListWithGenre(activeGenreId);
//    notifyListeners();
  }

  void changeCategory(Map<String, dynamic> genre) {
    activeGenreId = genre["id"];
//    notifyListeners();
    _loadMovieListWithGenre();
  }

}

//class MovieController extends ChangeNotifier {
//  var _movieRepository = MovieRepository();
//  var movies = <Movie>[];
//  var activeGenreId = -1;
//  var movieIndex = 0;
//
//
//  Future<List<Map<String, dynamic>>> loadGenre() async {
//    var genreList = await _movieRepository.loadGenre();
//    if (genreList.isNotEmpty) {
//      activeGenreId = genreList.first['id'].toInt();
//      _loadMovieListWithGenre();
//    }
////    print(genreList);
//    return genreList;
//  }
//
//  void _loadMovieListWithGenre() async {
////    await Future.delayed(Duration(seconds: 2));
//    movies = await _movieRepository.loadMovieListWithGenre(activeGenreId);
//    notifyListeners();
//  }
//
//  void changeCategory(Map<String, dynamic> genre) {
//    activeGenreId = genre["id"];
//    notifyListeners();
//    _loadMovieListWithGenre();
//  }
//
//}