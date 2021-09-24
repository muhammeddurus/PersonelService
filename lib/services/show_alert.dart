import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';

class AlertService {
  AuthService _authService = AuthService();

  static const String? message = "Yeni Personel Başarıyla Eklendi";
  static const String? message2 = "Email yada Şifre alanı boş bırakılamaz.";
  static const String? message3 = "Email yada Şifre hatalı.";
  static const String? message4 = "Zaten oturum açmış bir kullanıcı var.";
  static const String? message5 =
      "Girmiş olduğunuz bilgilere sahip kullanıcı bulunamadı.";
  static const String? message6 = "Mesainiz Başlatıldı.";
  static const String? message7 = "Mesainiz Bitirildi.";
  static const String? message8 = "Çıkış Yapmak İstediğinize Emin misiniz?";
  late BuildContext context;

  AlertService(this.context);

  showAlert() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert2() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message2"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert3() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message3"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert4() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message4"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert5() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message5"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert6() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message6"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert7() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message7"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  showAlert8() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text("$message8"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Vazgeç'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Çıkış Yap'),
                onPressed: () {
                  _authService.signOut(context).then((value) {
                    debugPrint("Çıkış Yapıldı");
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
