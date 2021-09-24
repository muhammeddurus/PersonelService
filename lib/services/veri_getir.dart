import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';

class VeriGetir {
  AuthService _authService = AuthService();

  Future<String> getUserName(String documentId) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("Personel")
        .doc(documentId)
        .get();
    debugPrint("ad" + snapshot.data()!['ad']);
    String ad = snapshot.data()!['ad'];
    debugPrint("$ad");
    return ad;
  }

  stream(Stream userStream, BuildContext context) {
    return StreamBuilder(
      stream: userStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        }).toList();
      },
    );
  }
}
