import 'package:flutter/material.dart';
import 'package:flutter_tmdb/src/components/category_movie_list.dart';
import 'package:flutter_tmdb/src/controller/movie_controller.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  late MovieController _movieController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _movieController = Provider.of<MovieController>(context, listen: false);
  }

  Widget _genreTag(Map<String, dynamic> genre) {
    var isActive = _movieController.activeGenreId == genre['id'];
    return GestureDetector(
      onTap: () {
        _movieController.changeCategory(genre);
        _movieController.movieIndex = 0;
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: isActive ? Colors.grey : Colors.white,
        ),
        child: Text(
          genre['name'],
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey, //
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Catergory'),
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: _movieController.loadGenre(),
//            initialData: InitialData,
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return Consumer<MovieController>(
                  builder: (context, value, child) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(snapshot.data!.length,
                                (index) => _genreTag(snapshot.data![index])),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

          }),
          CategoryMovieList(),
        ],
      ),
    );
  }
}
