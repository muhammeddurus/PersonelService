import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Admin/admin_login.dart';
import 'package:flutter_firebase_dersleri/Personel/home_page.dart';
import 'package:flutter_firebase_dersleri/Personel/yeni_personel.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';
import 'package:flutter_firebase_dersleri/services/geolocater_controller.dart';
import 'package:flutter_firebase_dersleri/services/show_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthService _authService = AuthService();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  final geolocatorController = Get.put(GeolocaterController());

  @override
  void initState() {
    super.initState();

    setState(() {
      getLocation();
    });
    debugPrint("init state çalıştı");
    _authService.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Oturum açmış kullanıcı yok init state');
      } else {
        print('Açık oturum var init state');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AlertService _alertService = AlertService(context);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminLoginPage()));
            },
            child: Icon(
              Icons.admin_panel_settings_outlined,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color(0xff392850),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/ayatek.jpg")),
                        borderRadius: BorderRadius.circular(150),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Personel Girişi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white70,
                              width: 0.1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _emailcontroller,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          ),
                          hintText: 'Email Adresinizi Giriniz',
                          labelText: 'EmailAdress *',
                        ),
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white70,
                              width: 0.1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        controller: _passwordcontroller,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.https,
                            color: Colors.white,
                          ),
                          hintText: 'Parolanızı giriniz',
                          labelText: 'Parola *',
                        ),
                        onSaved: (String? value) {},
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_authService.auth.currentUser != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        } else if (_emailcontroller.text != "" &&
                            _passwordcontroller.text != "") {
                          try {
                            _authService.signInFirst(_emailcontroller.text,
                                _passwordcontroller.text, context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "wrong-password") {
                              _alertService.showAlert3();
                            } else if (e.code == "user-not-found") {
                              _alertService.showAlert5();
                            }
                          }
                        } else {
                          _alertService.showAlert2();
                        }
                      },
                      child: Text("Oturum Aç"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff453680))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewUserPage()));
                      },
                      child: Text("Yeni Personel Oluştur."),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getLocation() {
    Geolocator.requestPermission().then((request) {
      if (Platform.isIOS) {
        if (request != LocationPermission.whileInUse) {
          return;
        } else {
          geolocatorController.permissionOK();
        }
      } else {
        if (request != LocationPermission.always) {
          return;
        } else {
          geolocatorController.permissionOK();
        }
      }
    });
  }
}
