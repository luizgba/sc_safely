import 'package:flutter/material.dart';
import 'package:Nas_Ruas/pages/homepage_geo.dart';
import 'package:Nas_Ruas/pages/signup_firebase.dart';
import 'package:Nas_Ruas/pages/reset-password.dart';
import 'package:Nas_Ruas/pages/homepage_geo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo-tela-login.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  "Recuperar Senha",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.black,
                /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color(0xFFF0bb846),
                      Color(0XFFFed242c),
                    ],
                  ),*/
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFfba619),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.black,
                /*gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color(0xFFF0bb846),
                      Color(0XFFFed242c),
                    ],
                  ),*/
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Registrar-se",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFfba619),
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_firebase()));
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

// bool valida(email, senha) {}
