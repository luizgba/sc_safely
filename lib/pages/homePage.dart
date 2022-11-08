import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GoogleMapController? mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = -26.5967228;
  double long = -53.5202882;
  String erro = '';

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google maps"),
      ),
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
          zoom: 11.0,
        ),
        markers: markers,
      ),
    );
  }

/*
  posicaoController() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    } catch (e) {
      erro = e.toString();
    }
    //notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
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
    }
    return await Geolocator.getCurrentPosition();
  }*/
}
