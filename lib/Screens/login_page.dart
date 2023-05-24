import 'package:finalproject1/Screens/home_page.dart';
import 'package:finalproject1/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> images = [
    'assets/images/anh1.webp',
    'assets/images/anh2.png',
    'assets/images/anh3.webp'
  ];
  int imageIndex = 0;
  String imgPath = 'assets/images/anh1.webp';
  TextEditingController _gmailControler = new TextEditingController();
  TextEditingController _passControler = new TextEditingController();
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(fontSize: 50),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 300,
                    width: 300,
                    child: Center(
                        child: Image.asset(
                      imgPath,
                      fit: BoxFit.fill,
                    ))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _gmailControler,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text(
                        'Gmail',
                        style: TextStyle(color: Colors.black38, fontSize: 20),
                      ),
                      /*labelText: 'email',*/
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(14))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: TextField(
                  autofocus: true,
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
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Forgot password',
                    style: TextStyle(fontSize: 18),
                  ),
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
                          .signInWithEmailAndPassword(
                              email: _gmailControler.text,
                              password: _passControler.text)
                          .then((value) => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()))
                              });
                    },
                    child: Text('Submit'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => SignUp()));
                  },
                  child: RichText(
                    text: TextSpan(
                        text: 'New user? ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(
                              text: 'Sign up for new account',
                              style: TextStyle(color: Colors.white))
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
