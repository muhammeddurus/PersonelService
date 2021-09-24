import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Personel/home_page.dart';
import 'package:flutter_firebase_dersleri/Personel/personel_login.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInDeneme(String email, String password) async {
    if (auth.currentUser == null) {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } else {
      print("Oturum açarken hata çıktı veya oturum açmış kullanıcı var");
    }
  }

  Future<User?> signInFirst(
      String email, String password, BuildContext context) async {
    if (auth.currentUser == null) {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("oturum açıldı ${user.user!.email.toString()}");
      await _firestore
          .collection("GirisTarihi")
          .doc(user.user!.uid)
          .set({'sonGirisTarihi': FieldValue.serverTimestamp()});
      debugPrint("giriş tarihi eklendi auth");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      return user.user;
    } else {
      girisYapanKullaniciyiAtYeniGirisYap(email, password, context);
      debugPrint(
          "Giriş yapmış bir kullanıcı vardı çıkış yapıldı yeni giriş işlemi başlatıldı auth.");
    }
  }

  Future<User?> girisYapanKullaniciyiAtYeniGirisYap(
      String email, String password, BuildContext context) async {
    signOut(context);
    if (auth.currentUser == null) {
      var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("oturum açıldı ${user.user!.email.toString()}");
      await _firestore.collection("GirisTarihi").doc(user.user!.uid).set(
          {'sonGirisTarihi': FieldValue.serverTimestamp()},
          SetOptions(merge: true));
      debugPrint("giriş tarihi eklendi auth");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      return user.user;
    }
  }

  Future<User?> signOut(BuildContext context) async {
    if (auth.currentUser != null) {
      var userId = auth.currentUser!.uid;
      await auth.signOut().then((value) {
        debugPrint("Oturum Kapatıldı auth service");
      });

      await _firestore.collection("GirisTarihi").doc(userId).set(
          {'sonCikisTarihi': FieldValue.serverTimestamp()},
          SetOptions(merge: true));
      debugPrint("çıkış tarihi eklendi auth");
      await auth.signOut();
      return Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SignInPage()));
    } else {
      debugPrint("Açık oturum yok ");
    }
  }

  oturumAcikmi() {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Oturum açmış kullanıcı yok');
      } else {
        print('Kullanıcı oturum açtı ve maili onaylı değil');
      }
    });
  }

  Future<User?> mesaiBaslat() async {
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("Personel")
            .doc(userId)
            .collection("MesaiBilgileri")
            .doc(
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({
          'mesaiBaslangicTarihi': FieldValue.serverTimestamp(),
          'name': userId
        }, SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı mesai başlatılamadı $e");
    }
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("MesaiDetay")
            .doc(
                "$userId--${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({
          'mesaiBaslangicTarihi': FieldValue.serverTimestamp(),
          'name': userId
        }, SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı mesai başlatılamadı $e");
    }
  }

  Future<User?> konumAl(String adress) async {
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("Personel")
            .doc(userId)
            .collection("KonumBilgileri")
            .doc(
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({'personelKonum': adress, 'name': userId},
                SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı konum kaydedilemedi $e");
    }
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("KonumDetay")
            .doc(
                "$userId--${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({'personelBaslangicKonum': adress, 'name': userId},
                SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı konum kaydedilemedi $e");
    }
  }

  Future<User?> konumAlBitis(String adress) async {
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("Personel")
            .doc(userId)
            .collection("KonumBilgileri")
            .doc(
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({'personelSonKonum': adress}, SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı konum kaydedilemedi $e");
    }
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("KonumDetay")
            .doc(
                "$userId--${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({'personelSonKonum': adress, 'name': userId},
                SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı konum kaydedilemedi $e");
    }
  }

  Future<User?> mesaiBitir() async {
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("Personel")
            .doc(userId)
            .collection("MesaiBilgileri")
            .doc(
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({'mesaiBitisTarihi': FieldValue.serverTimestamp()},
                SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı mesai bitirlemedi $e");
    }
    try {
      if (auth.currentUser != null) {
        var userId = auth.currentUser!.uid;
        await _firestore
            .collection("MesaiDetay")
            .doc(
                "$userId--${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}")
            .set({
          'mesaiBitisTarihi': FieldValue.serverTimestamp(),
          'name': userId
        }, SetOptions(merge: true));
      } else {
        debugPrint("user null");
      }
    } catch (e) {
      debugPrint("Hata çıktı mesai başlatılamadı $e");
    }
  }

  Future<User?> createPersonel(
      String sicilNo,
      String email,
      String password,
      String ad,
      String personelNo,
      String telefonNo,
      String departman,
      BuildContext context) async {
    var user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await _firestore.collection("Personel").doc(user.user!.uid).set({
      'sicilNo': sicilNo,
      'email': email,
      'password': password,
      'ad': ad,
      'personelNo': personelNo,
      'telefonNo': telefonNo,
      'departman': departman
    }, SetOptions(merge: true)).then((value) {
      return user.user;
    });
    signOut(context);
  }

  Future<User?> personelOlustur(
      String sicilNo,
      String email,
      String password,
      String ad,
      String personelNo,
      String telefonNo,
      String departman,
      BuildContext context) async {
    Map<String, dynamic> personelEkle = Map();
    DocumentSnapshot documentSnapshot =
        await _firestore.doc("users/$sicilNo").get();

    personelEkle['personelNo'] = personelNo;
    personelEkle['sicilNo'] = sicilNo;
    personelEkle['userDepartment'] = departman;
    personelEkle['userEmail'] = email;
    personelEkle['userName'] = ad;
    personelEkle['userPassword'] = password;
    personelEkle['userTelephone'] = telefonNo;
    try {
      _firestore
          .collection("personel")
          .doc(sicilNo)
          .set(personelEkle, SetOptions(merge: true))
          .then((v) => showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  if (documentSnapshot.exists == true) {
                    return AlertDialog(
                      title: const Text('UYARI'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text("Yeni personel başarıyla oluşturuldu."),
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
                  } else {
                    return AlertDialog(
                      title: const Text('UYARI'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text("Yeni personel oluşturulamadı."),
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
                  }
                },
              ));
    } catch (e) {
      debugPrint("********HATA VAR********" + e.toString());
    }
  }

  void _transactionEkle(User user) {
    final DocumentReference<Map<dynamic, dynamic>> df =
        _firestore.doc("Personel/${user.uid}");

    _firestore.runTransaction((transaction) async {
      DocumentSnapshot<Map<dynamic, dynamic>> snapshot =
          await transaction.get(df);
      debugPrint("doc id : " + snapshot.id);
      if (snapshot.exists) {
        var sonGirisTarihi = snapshot.data()!['sonGirisTarihi'];

        await transaction
            .update(df, {'sonGirisTarihi': FieldValue.serverTimestamp()});
      }
    });
  }
}
