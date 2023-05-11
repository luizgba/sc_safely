import 'package:flutter/material.dart';
import 'package:Nas_Ruas/pages/photoPage.dart';

Widget _builderTextFild_Endereco() {
  return TextField(
    decoration: InputDecoration(icon: Icon(Icons.location_pin), labelText: 'Escreva', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
  );
}

Widget _builderTextFild() {
  return TextField(
    decoration: InputDecoration(labelText: 'Escreva detalhadamente o que está ocorrendo', hintText: 'Digite algo aqui', border: OutlineInputBorder()),
    maxLines: 6,
  );
}

class WarningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Acontecimento'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              title: Text('Descreva o problema'),
            ),
            _builderTextFild(),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Tire uma foto ou grave um vídeo"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => photoPage(), fullscreenDialog: true),
              ),
            )
          ],
        ),
      ),
    );
  }
}
