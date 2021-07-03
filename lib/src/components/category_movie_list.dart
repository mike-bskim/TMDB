import 'package:flutter/material.dart';
import 'package:flutter_tmdb/src/controller/movie_controller.dart';
import 'package:flutter_tmdb/src/models/movie.dart';
import 'package:provider/provider.dart';


class CategoryMovieList extends StatelessWidget {
  const CategoryMovieList({Key? key}) : super(key: key);

  final MovieController movieController;

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
        children: [
          Text('NEW PLAYING'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<MovieController>(
              builder: (context, controller, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      controller.movies.length,
                      (movieController.movieIndex) => _movieWidget(controller.movies[movieController.movieIndex]),
                      growable: false,
                    ),
                  ),
                );
              },
              child: CategoryMovieList(),
            ),
          )
        ],
      ),
    );
  }
}
