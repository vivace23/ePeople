import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Loginorcreataccountpage extends StatefulWidget {
  const Loginorcreataccountpage({super.key});

  @override
  State<Loginorcreataccountpage> createState() => _LoginorcreataccountpageState();
}

class _LoginorcreataccountpageState extends State<Loginorcreataccountpage> {
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.push('/login');
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
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    context.push('/create_account');
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
                    child: Text("S'inscrire", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}