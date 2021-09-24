import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Admin/admin_ana_sayfa.dart';
import 'package:flutter_firebase_dersleri/Admin/personel_detay.dart';
import 'package:flutter_firebase_dersleri/Admin/personel_listesi.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';
import 'package:flutter_firebase_dersleri/services/geolocater_controller.dart';
import 'package:flutter_firebase_dersleri/services/show_alert.dart';
import 'package:flutter_firebase_dersleri/services/veriOkuma.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Personel').snapshots();
  final geolocatorController = Get.put(GeolocaterController());

  late List<Widget> tumSayfalar;
  Widget _anaSayfaAdmin = AnaSayfaAdmin();
  Widget _personelList = PersonelListesi();
  Widget _personelDetay = PersonelDetay();

  int secilenMenuItem = 0;
  double longitudeData = 0;
  double latitudeData = 0;

  AuthService _authService = AuthService();
  late AlertService _alertService;
  GetUserName? _getUserName;

  @override
  void initState() {
    super.initState();
    getLocation();
    _alertService = AlertService(context);
    _getUserName = GetUserName(_authService.auth.currentUser!.uid);
    tumSayfalar = [_anaSayfaAdmin, _personelList, _personelDetay];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                accountName: Text("Admin"),
                accountEmail: Text("admin@gmail.com"),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
        backgroundColor: Color(0xff392860),
        body: tumSayfalar[secilenMenuItem],
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Ana Sayfa",
            backgroundColor: Colors.amber),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Personel Listesi",
            backgroundColor: Colors.amber),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_search_rounded),
            label: "Personel Detay",
            backgroundColor: Colors.amber),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: secilenMenuItem,
      onTap: (index) {
        setState(() {
          secilenMenuItem = index;
        });
      },
    );
  }

  Future<List> getAdress(double latitudeData, double longitudeData) async {
    final coordinates = new Coordinates(latitudeData, longitudeData);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    debugPrint("Adresiniz : ${address.first.addressLine}");
    _authService.konumAl(address.first.addressLine);
    return address;
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
