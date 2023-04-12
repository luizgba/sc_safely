import 'package:flutter/material.dart';
import 'package:Nas_Ruas/pages/loginPage.dart';
import 'package:postgres/postgres.dart';

Future main() async {
  /*
  Future operation() async {
    var connection = PostgreSQLConnection(
        "ec2-31-242-24-212.compute-1.amazonaws.com", // hostURL
        5432, // port
        "djb7v0k318g55", // databaseName
        username: "ggfplrsgbytwdc",
        password: "b72bf90efb5e5f52b3c22a87f7ef5f76f80e663583",
        useSSL: true);

    await connection.open();
    print("Connected");
  }
  */

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/*
void main() {
  runApp(const MyApp());
}
*/
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nas Ruas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}
