import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject1/Screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Logics/getApi.dart';
import 'package:flutter/material.dart';
import 'details.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<dynamic> _futureData;
  int selectIndex = 1;
  @override
  void initState() {
    super.initState();
    _futureData = getData();
  }

  bool bottomTap = false;
  void onTapHandle(int index) {
    setState(() {
      selectIndex = index;
      bottomTap = true;
    });
  }

/*
  */ /*Widget getBody() {
    if (selectIndex == 0) {

      return Favorite();
    } else if (selectIndex == 1) {
      return HomePage();
    } else {
      return History();
    }*/ /*
  }*/
  Future<String> getDocument() async {
    final docUser = FirebaseFirestore.instance.collection('User').doc();

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(docUser.id)
        .get();

    // Tài liệu tồn tại
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    String name = data['name']; // Lấy giá trị của trường "name"
    print(name);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Text('Option')),
              Text(getDocument().toString()),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()))
                        });
                  },
                  child: Text('Log out'))
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(
            'Home',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: FutureBuilder<dynamic>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              var data = snapshot.data;
              return ListView.builder(
                itemCount: data['data'].length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Detail(detail: data['data'][index])));
                        },
                        child: Card(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Image.network(
                                  '${data['data'][index]['images']['jpg']['image_url']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                '${data['data'][index]['titles'][0]['title']}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return Container();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          backgroundColor: Colors.blue[900],
          iconSize: 30,
          onTap: onTapHandle,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'history')
          ],
        ),
      ),
    );
  }
}
