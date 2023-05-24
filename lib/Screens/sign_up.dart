import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject1/Screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalproject1/Logics/user.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {
  //const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class User {
  String id;
  String? name;
  var history;
  var favorite;

  User({required this.id, this.name, this.history, this.favorite});

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'history': history, 'favorite': favorite};
}

class _SignUpState extends State<SignUp> {
  List<String> images = [
    'assets/images/anh1.webp',
    'assets/images/anh2.png',
    'assets/images/anh3.webp'
  ];
  int imageIndex = 0;
  String imgPath = 'assets/images/anh1.webp';

  //Validate validate = new Validate();
  TextEditingController _nameControler = new TextEditingController();
  TextEditingController _gmailControler = new TextEditingController();
  TextEditingController _passControler = new TextEditingController();

  /*@override
  void dispose() {
    validate.dispose();
    super.dispose();
  }*/

  Future addUser() async {
    final docUser = FirebaseFirestore.instance.collection('User').doc();

    final user = User(
        id: docUser.id, name: _nameControler.text, history: [], favorite: []);

    final json = user.toJson();

    await docUser.set(json);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setImgPath();
  }

  void setImgPath() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        imageIndex = (imageIndex + 1) % images.length;
        imgPath = images[imageIndex];
        setImgPath(); // goi lai ham cho lan tiep theo
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign up',
          style: TextStyle(fontSize: 50),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                        child: Image.asset(
                      imgPath,
                      fit: BoxFit.fill,
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: _nameControler,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'User name ',
                        style: TextStyle(color: Colors.black38, fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(14))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: _gmailControler,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Gmail',
                        style: TextStyle(color: Colors.black38, fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(14))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: TextField(
                  controller: _passControler,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Password',
                        style: TextStyle(color: Colors.black38, fontSize: 20),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(14))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      minimumSize: Size(double.infinity, 70),
                      textStyle: TextStyle(fontSize: 26),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _gmailControler.text,
                              password: _passControler.text)
                          .then((value) => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginPage()))
                              });
                      addUser();
                    },
                    child: Text('Sign up'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*void connectFirebase() async {
  // Kết nối với Firebase
  await Firebase.initializeApp();

  // Đăng nhập vào FirebaseAuth
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: 'your_email@example.com',
    password: 'your_password',
  );

  // Lấy ID của FirebaseAuth
  String uid = userCredential.user!.uid;

  // Kết nối với Firestore và thực hiện các tác vụ
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Thêm dữ liệu vào Firestore
  await firestore.collection('users').doc(uid).set({
    'name': 'John Doe',
    'email': 'john.doe@example.com',
  });

  // Truy vấn dữ liệu từ Firestore
  DocumentSnapshot snapshot = await firestore.collection('users').doc(uid).get();
  Map<String, dynamic>? userData = snapshot.data();
  if (userData != null) {
    String name = userData['name'];
    String email = userData['email'];
    print('Name: $name');
    print('Email: $email');
  }
}*/
