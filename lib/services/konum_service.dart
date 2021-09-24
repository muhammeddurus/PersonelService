import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';

class KonumIslemleri {
  AuthService _authService = AuthService();

  Future<List> getKonumBitis(
      double latitudeData, double longitudeData, BuildContext context) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy - HH:mm').format(now);

    final coordinates = new Coordinates(latitudeData, longitudeData);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    debugPrint("Adresiniz Bitiş : ${address.first.addressLine}");
    _authService.konumAl(address.first.addressLine);

    String konum = address.first.addressLine;
    debugPrint("getAdress Bitiş " + konum.toString());

    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Mesainiz bitirildi."),
                  Text("Konumunuz: $konum"),
                  Text("$formattedDate"),
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
    return address;
  }

  Future<List> getKonumBaslat(
      double latitudeData, double longitudeData, BuildContext context) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy - HH:mm').format(now);

    final coordinates = new Coordinates(latitudeData, longitudeData);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    debugPrint("Adresiniz : ${address.first.addressLine}");
    _authService.konumAl(address.first.addressLine);

    String konum = address.first.addressLine;
    debugPrint("getAdress konum " + konum.toString());

    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ALERT'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Mesainiz başlatıldı."),
                  Text("Konumunuz: $konum"),
                  Text("$formattedDate"),
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

    return address;
  }
}
