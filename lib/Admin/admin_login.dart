import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Admin/admin_page.dart';
import 'package:flutter_firebase_dersleri/services/admin_service.dart';
import 'package:flutter_firebase_dersleri/services/show_alert.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  AdminService _adminService = AdminService();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _adminService.auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Oturum açmış kullanıcı yok init state');
      } else {
        print('Açık oturum var init state');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AdminPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AlertService _alertService = AlertService(context);
    return Scaffold(
      floatingActionButton: InkWell(
        child: Icon(
          Icons.home,
          size: 50,
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.amber,
      body: Container(
        padding: EdgeInsets.all(16),
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
            Text(
              "Admin Girişi",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                hintText: 'Kullanıcı Adınızı Giriniz',
                labelText: 'username *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            ),
            TextFormField(
              controller: _passwordcontroller,
              decoration: InputDecoration(
                icon: Icon(Icons.https),
                hintText: 'Parolanızı giriniz',
                labelText: 'password *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_adminService.auth.currentUser != null) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminPage()));
                } else if (_emailcontroller.text != "" &&
                    _passwordcontroller.text != "") {
                  try {
                    _adminService.signInFirst(_emailcontroller.text,
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xff392860))),
            ),
          ],
        ),
      ),
    );
  }
}
