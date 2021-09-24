import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Admin/admin_login.dart';
import 'package:flutter_firebase_dersleri/Admin/admin_page.dart';
import 'package:flutter_firebase_dersleri/Personel/home_page.dart';

class AdminService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInFirst(
      String email, String password, BuildContext context) async {
    if (auth.currentUser == null) {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("oturum açıldı ${user.user!.email.toString()}");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AdminPage()));
      return user.user;
    } else {
      _girisYapanAdminiAtYeniGirisYap(email, password, context);
      debugPrint(
          "Giriş yapmış bir kullanıcı vardı çıkış yapıldı yeni giriş işlemi başlatıldı auth.");
    }
  }

  Future<User?> _girisYapanAdminiAtYeniGirisYap(
      String email, String password, BuildContext context) async {
    signOut(context);
    if (auth.currentUser == null) {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      return user.user;
    }
  }

  Future<User?> signOut(BuildContext context) async {
    if (auth.currentUser != null) {
      await auth.signOut().then((value) {
        debugPrint("Oturum Kapatıldı auth service");
      });
      await auth.signOut();
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AdminLoginPage()));
    } else {
      debugPrint("Açık oturum yok ");
    }
  }
}
