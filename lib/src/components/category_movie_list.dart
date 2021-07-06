import 'package:flutter/material.dart';
import 'package:flutter_tmdb/src/controller/movie_controller.dart';
import 'package:flutter_tmdb/src/models/movie.dart';
import 'package:get/get.dart';
//import 'package:provider/provider.dart';


class CategoryMovieList extends StatelessWidget {
//  const CategoryMovieList({Key? key}) : super(key: key);

  final MovieController _movieController = Get.put(MovieController(Colors.white.obs, Colors.grey.obs));

  Widget _movieWidget(Movie movie) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(right: 10),
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(movie.posterUrl),
          ),
          SizedBox(height: 10),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            movie.voteAverage.toString(),
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('NEW PLAYING'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(()=>Row(
              children: List.generate(
                  _movieController.movies.length,
                (movieIndex) => _movieWidget(_movieController.movies[movieIndex]),
                growable: false,
              ),
            ))
          ),
        ],
      ),
    );
  }
}
