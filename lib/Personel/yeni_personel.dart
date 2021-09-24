import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Admin/admin_login.dart';
import 'package:flutter_firebase_dersleri/Personel/personel_login.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';
import 'package:flutter_firebase_dersleri/services/show_alert.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  AuthService _authService = AuthService();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _sicilNocontroller = TextEditingController();
  final TextEditingController _personelNocontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _passwordcontroller2 = TextEditingController();
  final TextEditingController _adcontroller = TextEditingController();
  final TextEditingController _telefoncontroller = TextEditingController();
  final TextEditingController _departmancontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AlertService _alertService = AlertService(context);

    return Scaffold(
      backgroundColor: Color(0xff392850),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminLoginPage()));
            },
            icon: Icon(Icons.admin_panel_settings),
          )
        ],
        title: Text("Yeni Kullanıcı"),
        elevation: 0,
      ),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Yeni Personel Kayıt",
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
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _sicilNocontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      hintText: 'Sicil No giriniz',
                      labelText: 'Sicil No *',
                    ),
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      hintText: 'Email Adresinizi Giriniz',
                      labelText: 'Email *',
                    ),
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.https,
                        color: Colors.white,
                      ),
                      hintText: 'Parolanızı giriniz',
                      labelText: 'Parola *',
                    ),
                    validator: (deger) {
                      deger = _passwordcontroller.text;
                      if (deger.length < 6) {
                        return 'Parola en az 6 karakterden oluşmalıdır.';
                      } else
                        return null;
                    },
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordcontroller2,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.https,
                        color: Colors.white,
                      ),
                      hintText: 'Parolanızı tekrar giriniz',
                      labelText: 'Parola *',
                    ),
                    validator: (deger) {
                      deger = _passwordcontroller2.text;
                      if (deger != _passwordcontroller.text) {
                        return 'Girdiğiniz parolalar aynı değil.';
                      } else
                        return null;
                    },
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _adcontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      hintText: 'Adınızı giriniz',
                      labelText: 'Ad *',
                    ),
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _personelNocontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person_search_rounded,
                        color: Colors.white,
                      ),
                      hintText: 'Personel No giriniz',
                      labelText: 'Personel No *',
                    ),
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _telefoncontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      hintText: 'Telefon No giriniz',
                      labelText: 'Telefon No *',
                    ),
                    onSaved: (String? value) {},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _departmancontroller,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.home_work,
                        color: Colors.white,
                      ),
                      hintText: 'Departman giriniz',
                      labelText: 'Departman *',
                    ),
                    onSaved: (String? value) {},
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //_kullaniciOlustur();
                      _authService
                          .createPersonel(
                              _sicilNocontroller.text,
                              _emailcontroller.text,
                              _passwordcontroller.text,
                              _adcontroller.text,
                              _personelNocontroller.text,
                              _telefoncontroller.text,
                              _departmancontroller.text,
                              context)
                          .then((value) {
                        _alertService.showAlert();
                        return Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignInPage()));
                      });
                    },
                    child: Text("Yeni Personel Oluştur"),
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
    );
  }
}
