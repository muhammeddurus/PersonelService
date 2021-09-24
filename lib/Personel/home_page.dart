import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Personel/ana_sayfa.dart';
import 'package:flutter_firebase_dersleri/Personel/personel_list.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';
import 'package:flutter_firebase_dersleri/services/geolocater_controller.dart';
import 'package:flutter_firebase_dersleri/services/konum_service.dart';
import 'package:flutter_firebase_dersleri/services/show_alert.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> tumSayfalar;
  Widget _anaSayfaPersonel = AnaSayfaPersonel();
  Widget _personelList = PersonelList();

  final geolocatorController = Get.put(GeolocaterController());

  KonumIslemleri _konumIslemleri = KonumIslemleri();

  int secilenMenuItem = 0;
  double longitudeData = 0;
  double latitudeData = 0;

  AuthService _authService = AuthService();
  late AlertService _alertService;
  String? konum;

  @override
  void initState() {
    super.initState();

    _alertService = AlertService(context);
    tumSayfalar = [_anaSayfaPersonel, _personelList];
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Personel')
        .doc(_authService.auth.currentUser!.uid)
        .snapshots();
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.amber),
                accountName: StreamBuilder(
                  stream: _usersStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    } else {
                      var response = snapshot.data!.data();
                      return Text(
                        response!['ad'],
                      );
                    }
                  },
                ),
                accountEmail: StreamBuilder(
                  stream: _usersStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    } else {
                      var response = snapshot.data!.data();
                      return Text(
                        response!['email'],
                      );
                    }
                  },
                ),
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilderEx(usersStream: _usersStream),
              )
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
        backgroundColor: Color(0xff392850),
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
            backgroundColor: Color(0xff392860)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Personeller",
            backgroundColor: Colors.blue),
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
}

class StreamBuilderEx extends StatelessWidget {
  const StreamBuilderEx({
    Key? key,
    required Stream<DocumentSnapshot<Object?>> usersStream,
  })  : _usersStream = usersStream,
        super(key: key);

  final Stream<DocumentSnapshot<Object?>> _usersStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        } else {
          var response = snapshot.data!.data();
          return ListView(
            children: [
              ListTile(
                title: Text("Ad   "),
                subtitle: Text(response!['ad']),
              ),
              ListTile(
                title: Text("Email   "),
                subtitle: Text(response!['email']),
              ),
              ListTile(
                title: Text("Sicil No   "),
                subtitle: Text(response!['sicilNo']),
              ),
              ListTile(
                title: Text("Personel No   "),
                subtitle: Text(response!['personelNo']),
              ),
              ListTile(
                title: Text("Telefon No  "),
                subtitle: Text(response!['personelNo']),
              ),
              ListTile(
                title: Text("Departman  "),
                subtitle: Text(response!['departman']),
              ),
              ListTile(
                title: Text("Departman  "),
                subtitle: Text(response!['departman']),
              ),
            ],
          );
        }
      },
    );
  }
}
