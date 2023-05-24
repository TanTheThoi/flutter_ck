import 'package:finalproject1/Screens/trailer.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final dynamic detail;
  Detail({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> genres = detail['genres'];
    List<dynamic> genreNames = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${detail['titles'][0]['title']}',
          textAlign: TextAlign.center,
        ),
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                      child: Stack(children: [
                    Image.network('${detail['images']['jpg']['image_url']}'),
                    Positioned(
                      top: 130,
                      left: 90,
                      child: InkWell(
                        onTap: () {
                          print('hello');
                        },
                        child: Icon(
                          Icons.play_circle_outline_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    )
                  ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '${detail['titles'][0]['title']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Text(
                  detail['episodes'] == null
                      ? 'Episodes: ???'
                      : 'Episodes: ${detail['episodes']}',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TrailerPage(
                                  name: detail['titles'][0]['title'],
                                  trailer: detail['trailer']['url'] ??
                                      'https://www.youtube.com/watch?v=dA6aayUBvdw')));
                    },
                    child: Text(
                      'Trailer',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        backgroundColor: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Genres: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Row(
                        children: genreNames = genres
                            .map<Widget>((genre) => Text(
                                  '${genre['name']},  ',
                                  style: TextStyle(fontSize: 20),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: RichText(
                      text: TextSpan(
                          text: 'Synopsis: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                          children: [
                        TextSpan(
                          text: '${detail['synopsis'].toString()}',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        )
                      ])),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
