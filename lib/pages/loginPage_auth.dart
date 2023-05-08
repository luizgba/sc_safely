import 'package:flutter/material.dart';
import 'package:Nas_Ruas/pages/signup_firebase.dart';
import 'package:Nas_Ruas/pages/reset-password.dart';
import 'package:Nas_Ruas/pages/homepage_geo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class loginPage_auth extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Verifica se o usuário está registrado no Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).get();

      if (userSnapshot.exists) {
        // Navega para a página principal após o login
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        // Caso o usuário não esteja registrado, exibe uma mensagem de erro
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro de Login"),
              content: Text("Usuário não encontrado. Realize o cadastro antes de fazer o login."),
              actions: <Widget>[
                TextButton(
                  child: Text("Fechar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro de Login"),
              content: Text("Usuário não encontrado. Verifique o e-mail e senha informados."),
              actions: <Widget>[
                TextButton(
                  child: Text("Fechar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro de Login"),
              content: Text("Senha incorreta. Verifique o e-mail e senha informados."),
              actions: <Widget>[
                TextButton(
                  child: Text("Fechar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Erro de Login"),
              content: Text("Ocorreu um erro ao efetuar o login. Tente novamente mais tarde."),
              actions: <Widget>[
                TextButton(
                  child: Text("Fechar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

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
              controller: _emailController,
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
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
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
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFFFfba619),
                    Color(0xFFFfba619),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/icones/log-in.png"),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    _signIn(context);
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
                color: Color(0xFF3C5A99),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Cadastrar-se",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/icones/sign-up.png"),
                          height: 28,
                          width: 28,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup_firebase()),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Text(
                  "Esqueceu sua senha?",
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
