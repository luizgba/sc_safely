import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Nas_Ruas/pages/warningpage.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GoogleMapController? mapController;
  Set<Circle> _circles = HashSet<Circle>();
  double lat = -26.5967228;
  double long = -53.5202882;
  String erro = '';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _setCircles() {
    _circles.add(Circle(circleId: CircleId("0"), center: LatLng(lat, long), radius: 10, strokeWidth: 2, fillColor: Color(0xFFFC8F4FF).withOpacity(0.5)));
  }

  @override
  void initState() {
    super.initState();
    _setCircles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WarningPage()));
        },
        backgroundColor: Color(0xFFFfba619),
        child: const Icon(Icons.warning),
      ),
      //appBar: AppBar(
      //  title: Text("Google maps"),
      //),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onCameraMove: (data) {
          print(data);
        },
        onTap: (position) {
          print(position);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, long),
          zoom: 20.0,
        ),
        circles: _circles,
      ),
    );
  }

  posicaoController() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position? posicao = await _posicaoAtual();
      setState(() {
        lat = posicao!.latitude;
        long = posicao!.longitude;
      });
    } catch (e) {
      erro = e.toString();
    }
    //notifyListeners();
  }

  Future<Position?> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error("Por favor, ative a localização");
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        return Future.error("Por favor, ajuste as permissões de seu dispositivo");
      }

      if (permissao == LocationPermission.deniedForever) {
        return Future.error("Verifique as permissões");
      }
      return Geolocator.getCurrentPosition();
    }
  }
}
