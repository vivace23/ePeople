import 'dart:convert';

import 'package:epeople/models/User.dart';
import 'package:epeople/widget/authentification/modalInformation.dart';
import 'package:epeople/widget/authentification/modalLoaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;


class Createaccountpage extends StatefulWidget {
  const Createaccountpage({super.key});

  @override
  State<Createaccountpage> createState() => _CreateaccountpageState();
}

class _CreateaccountpageState extends State<Createaccountpage> {

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    phoneController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
  }

  // fonction pour creer un utilisateur
  void _createAccount() {

   showLoadingDialog(context, 'Création de compte en cours...');

    User user = User(
      id: 1,
      nom: nomController.text,
      prenom: prenomController.text,
      contact: phoneController.text,
      email: emailController.text,
      username: usernameController.text,
      motDePasse: passwordController.text,
    );
  
    // pour enregistrer l'utilisateur dans la base de données
    user.sendUserToApi('https://jsonplaceholder.typicode.com/users', user.toJson())
    .then((value) {
      Navigator.pop(context);
      showInformationDialog(context, 'Compte créé avec succès',true);
      // Navigator.pushNamed(context, '/login');
    })
    .catchError((error) {
      Navigator.pop(context);
      showInformationDialog(context, 'Une erreur s\'est produite lors de la création du compte', false);
      print('Erreur: $error');
    });

    user.signUp("avydevy@gmail.com", 'password');
  }

  Future<void> sendDataToApi() async {
    // URL de l'API (remplace par ton endpoint réel)
    final String apiUrl = 'http://52.56.190.142:81/authCovoitureur/register_covoitureur';

    // Données à envoyer (par exemple, un objet JSON)
    final Map<String, dynamic> data = {
      'nom': nomController.text,
      'prenom': prenomController.text,
      'email':  emailController.text,
      'contact': phoneController.text,
      'sexe': true,
      'mot_de_passe': passwordController.text,
      'username': usernameController.text,
    };

    try {
      // Envoi de la requête POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Indique que les données sont en JSON
        },
        body: jsonEncode(data), // Convertit les données en JSON
      );

      // Vérification de la réponse
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Données envoyées avec succès : ${response.body}');
      } else {
        print('Erreur lors de l’envoi : ${response.statusCode}');
      }
    } catch (e) {
      print('Une erreur est survenue : $e');
    }
  }

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
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(4.0, 4.0),
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text("Page d'inscription", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(4.0, 4.0),
                      ),
                      ],
                    )),
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

                          // nom et prenom
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
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
                                    controller: nomController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Nom",
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
                                    controller: prenomController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Prenom(s)",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),

                          // numero de telephone et email
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
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
                                    controller: phoneController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: "Numéro de téléphone",
                                        prefixIcon: Icon(FontAwesomeIcons.phone),
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
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Icon(FontAwesomeIcons.envelope),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8,),

                          // nom d'utilisateur et mot de passe
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
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
                                    controller: usernameController,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "Nom d'utilisateur",
                                      prefixIcon: Icon(FontAwesomeIcons.user),
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
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: "Mot de passe",
                                      prefixIcon: Icon(FontAwesomeIcons.lock),
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
                                    controller: confirmPasswordController,
                                    decoration: InputDecoration(
                                      hintText: "Confirmer le mot de passe",
                                      prefixIcon: Icon(FontAwesomeIcons.lock),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                
                          SizedBox(height: 10,),

                          GestureDetector(
                            onTap: () {
                              sendDataToApi();
                            },
                            child: Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                colors: [Colors.orange[900]!, Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Text("je m'inscris", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),

                          SizedBox(height: 20,),

                          Text("Continuer avec les réseaux sociaux", style: TextStyle(color: Colors.grey),),

                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // pour s'inscrire avec facebook
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

                              // pour s'inscrire avec google
                              GestureDetector(
                                onTap: () {
                                  print("google");
                                },
                                child:
                                FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 50.0,
                                  color: Color(0xFFDB4437),
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