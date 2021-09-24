import 'package:flutter/material.dart';
import 'package:flutter_firebase_dersleri/Personel/personel_login.dart';
import 'package:flutter_firebase_dersleri/services/aut_service.dart';

class AnaSayfaAdmin extends StatefulWidget {
  const AnaSayfaAdmin({Key? key}) : super(key: key);

  @override
  _AnaSayfaAdminState createState() => _AnaSayfaAdminState();
}

class _AnaSayfaAdminState extends State<AnaSayfaAdmin> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                          content:
                              Text("Çıkış Yapmak İstediğinize Emin misiniz ?"),
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
              "Admin Paneli",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          personelIslemleri()
        ],
      ),
    );
  }

  Padding personelIslemleri() {
    return Padding(
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
                            "assets/images/computer.png",
                            width: 64.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Personeller",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
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
                            "assets/images/hourglass.png",
                            width: 64.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Detay",
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
          ],
        ),
      ),
    );
  }
}
