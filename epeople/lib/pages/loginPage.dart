import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
            )
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                    children: [
                      Text.rich(
                      TextSpan(
                          children: [
                          TextSpan(
                          text: 'e',
                          style: TextStyle(color: Colors.orange, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                          text: 'People',
                          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          ],
                        ),
                      ),
                    ],
                    ),
                    Text("Page de connexion", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10,left: 10, right: 10), // Marge horizontale et verticale
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 3),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)
                                )
                              ]
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Email ou numéro de téléphone",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                                  ),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Mot de passe",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),
                          Text("Mot de passe oublié?", style: TextStyle(color: Colors.grey),),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                colors: [Colors.green, Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Text("Se connecter", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text("Continuer avec les réseaux sociaux", style: TextStyle(color: Colors.grey),),
                          SizedBox(height: 5,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // pour se connecter avec facebook
                              GestureDetector(
                                onTap: () {
                                  print("Facebook");
                                },
                                child:
                                FaIcon(
                                  FontAwesomeIcons.facebook,
                                  size: 50.0,
                                  color: Colors.blue,
                                )
                              ),
                              SizedBox(width: 30,),
                              GestureDetector(
                                onTap: () {
                                  print("Facebook");
                                },
                                child:
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 50.0,
                                  color: Color(0xFFDB4437), // Google red color
                                )
                              ),
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}