import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Nas_Ruas/pages/loginPage_auth.dart';

class Signup_firebase extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _senhacontroller = TextEditingController();

  void _cadastrarUsuario(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _senhacontroller.text,
        );

        await FirebaseFirestore.instance.collection('usuarios').doc(userCredential.user!.uid).set({
          'email': _emailcontroller.text,
        });

        // Navega para a próxima página após o cadastro
        Navigator.push(context, MaterialPageRoute(builder: (context) => loginPage_auth()));
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erro ao cadastrar usuário"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, left: 40, right: 40),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                alignment: Alignment(0.0, 1.15),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: AssetImage("assets/profile-picture.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailcontroller,
                // autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "E-mail",
                  hintText: "nome@email.com",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "Digite seu email";
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _senhacontroller,
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
                validator: (senha) {
                  if (senha == null || senha.isEmpty) {
                    return "Digite sua senha";
                  } else if (senha.length < 6) {
                    return "Digite uma senha mais forte";
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 20,
                ),
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
                      Color(0xFFF58524),
                      Color(0XFFF92B7F),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: SizedBox.expand(
                  child: TextButton(
                    onPressed: () {
                      _cadastrarUsuario(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Cadastrar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => loginPage_auth(),
                    ),
                  ),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
