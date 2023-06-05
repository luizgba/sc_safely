import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Nas_Ruas/pages/photoPage.dart';
import 'package:Nas_Ruas/pages/homepage_geo.dart';

class WarningPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  WarningPage({required this.latitude, required this.longitude});

  @override
  _WarningPageState createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
  final _descricaoController = TextEditingController();

  void _salvarOcorrencia() async {
    try {
      await FirebaseFirestore.instance.collection('ocorrencias').add({
        'latitude': widget.latitude,
        'longitude': widget.longitude,
        'descricao': _descricaoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ocorrência salva com sucesso"),
        ),
      );
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao salvar ocorrência"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Acontecimento'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Descreva o problema'),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Escreva detalhadamente o que está ocorrendo',
                hintText: 'Digite algo aqui',
                border: OutlineInputBorder(),
              ),
              maxLines: 6,
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Tire uma foto ou grave um vídeo"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => photoPage(), fullscreenDialog: true),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _salvarOcorrencia();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text(
                "Salvar",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFfba619),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
