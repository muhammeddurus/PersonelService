import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Personel/personel_login.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';
import 'package:flutter_firebase_dersleri/services/geolocater_controller.dart';
import 'package:flutter_firebase_dersleri/services/konum_service.dart';
import 'package:flutter_firebase_dersleri/services/show_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AnaSayfaPersonel extends StatefulWidget {
  const AnaSayfaPersonel({Key? key}) : super(key: key);

  @override
  _AnaSayfaPersonelState createState() => _AnaSayfaPersonelState();
}

class _AnaSayfaPersonelState extends State<AnaSayfaPersonel> {
  final geolocatorController = Get.put(GeolocaterController());

  KonumIslemleri _konumIslemleri = KonumIslemleri();

  double longitudeData = 0;
  double latitudeData = 0;

  AuthService _authService = AuthService();
  late AlertService _alertService;
  String? konum;

  @override
  void initState() {
    super.initState();
    getLocation();
    _alertService = AlertService(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: AssetImage("assets/images/profile.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Çıkış Yapmak İstediğinize Emin misiniz ?"),
                            action: SnackBarAction(
                              label: "Evet",
                              onPressed: () {
                                _authService.signOut(context);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                              },
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                "Personel Servisleri",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: InkWell(
                        onTap: () {
                          try {
                            _authService.mesaiBaslat().then((value) {
                              debugPrint("Mesai Başlatıldı");
                            });
                            getLocation();
                            latitudeData =
                                geolocatorController.currentLocation.latitude;
                            longitudeData =
                                geolocatorController.currentLocation.longitude;
                            _konumIslemleri.getKonumBaslat(
                                latitudeData, longitudeData, context);

                            print(
                                'x:${latitudeData.toString()},y: ${longitudeData.toString()}');
                          } catch (e) {
                            debugPrint("Hata çıktı mesai başlatılamadı $e");
                          }
                        },
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/computer.png",
                                    width: 64.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Mesai Başlat",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Work",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: InkWell(
                        onTap: () {
                          try {
                            _authService.mesaiBitir().then((value) {
                              debugPrint("Mesai Bitirildi");
                            });
                            getLocation();
                            latitudeData =
                                geolocatorController.currentLocation.latitude;
                            longitudeData =
                                geolocatorController.currentLocation.longitude;
                            _konumIslemleri.getKonumBitis(
                                latitudeData, longitudeData, context);

                            print(
                                'x:${latitudeData.toString()},y: ${longitudeData.toString()}');
                          } catch (e) {
                            debugPrint("Hata çıktı mesai bitirilemedi $e");
                          }
                        },
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/hourglass.png",
                                    width: 64.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Mesai Bitir",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "2 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/loading.png",
                                    width: 64.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Test",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "2 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: InkWell(
                        onTap: () {},
                        child: Card(
                          color: Color.fromARGB(255, 21, 21, 21),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/loading.png",
                                    width: 64.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Test",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "2 Items",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
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
