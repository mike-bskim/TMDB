import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_tmdb/src/components/category_movie_list.dart';
import 'package:flutter_tmdb/src/controller/movie_controller.dart';
import 'package:get/get.dart';
//import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

//  final MovieController _movieController = Get.put(MovieController(Colors.white.obs, Colors.grey.obs));
  final MovieController _movieController = Get.put(MovieController());
  final ButtonColorController _buttonColorController = Get.put(ButtonColorController());
  final TextColorController _textColorController = Get.put(TextColorController());

  @override
  void initState() {
    super.initState();
  }

  Widget _genreTag(Map<String, dynamic> genre) {
    print('_genreTag >>>>>>>>>>>>>>>>>>>');
//    var isActive = _movieController.activeGenreId.value == genre['id'];
    if(_movieController.activeGenreId == genre['id']) {
      _buttonColorController.changeColor(Colors.grey);
      _textColorController.changeColor(Colors.white);
//      print('지정한 영화장르: ${_movieController.activeGenreId.toString()}');
    } else {
      _buttonColorController.changeColor(Colors.white);
      _textColorController.changeColor(Colors.grey);
//      print('지정되지 않은 영화장르: ${genre['id'].toString()}');
    }
//    print('isActive(${isActive.toString()}), id(${genre['id'].toString()})');
    return GestureDetector(
      onTap: () {
        _movieController.changeCategory(genre);
//        print('activeGenreId: '+ _movieController.activeGenreId.value.toString());
//        print(genre['id']);
      },
      child: Obx(()=>Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
//          color: isActive ? Colors.grey : Colors.white,
//          color: _movieController.containerColor.value,
          color: _buttonColorController.buttonColor.value,
        ),
        child: Text(
          genre['name'],
          style: TextStyle(
//            color: isActive ? Colors.white : Colors.grey, //
//            color: _movieController.textColor.value, //
            color: _textColorController.textColor.value,
            fontWeight: FontWeight.bold, //isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      )),
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
                return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(snapshot.data.length,
                                (index) => _genreTag(snapshot.data[index])),
                      ),
                    );

              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

          }),
          CategoryMovieList(), // => 장르별 영화정보를 표시하는 부분
        ],
      ),
    );
  }
}
