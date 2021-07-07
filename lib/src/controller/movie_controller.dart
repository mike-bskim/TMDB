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
//  Rx<Color> containerColor = Colors.white.obs;
//  Rx<Color> textColor = Colors.grey.obs;

//  MovieController(this.containerColor, this.textColor); //  RxInt _movieIndex = 0.obs;


//  void colorUpdate(Color color1, Color color2) {
//    containerColor(color1);
//    textColor(color2);
//  }

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

class ButtonColorController extends GetxController {
  Rx<Color> buttonColor = Colors.white.obs;
  void changeColor(Color color) {
    buttonColor(color);
  }
}

class TextColorController extends GetxController {
  Rx<Color> textColor = Colors.black.obs;
  void changeColor(Color color) {
    textColor(color);
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