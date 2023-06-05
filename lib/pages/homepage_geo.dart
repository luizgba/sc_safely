import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Nas_Ruas/pages/warningpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Verifica se o serviço de localização está ativado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: "Por favor, ative a localização do telefone",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    // Verifica se a permissão de localização foi concedida
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
          msg: "Permissão de localização negada",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
        return;
      }
    }

    // Obtem a posição atual do usuário
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _loadMarkers();
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            zoom: 15,
          ),
        ),
      );
    }
  }

  void _loadMarkers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('ocorrencias').get();
    List<Marker> markers = [];

    snapshot.docs.forEach((doc) {
      double latitude = doc['latitude'];
      double longitude = doc['longitude'];
      String descricao = doc['descricao'];

      Marker marker = Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: descricao), // Exibe a descrição como título na janela de informações do marcador
      );

      markers.add(marker);
    });

    if (_currentPosition != null) {
      Marker currentLocationMarker = Marker(
        markerId: MarkerId('current_location'),
        position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), // Ícone personalizado para a posição atual
        infoWindow: InfoWindow(title: 'Minha localização'), // Exibe um título na janela de informações do marcador
      );

      markers.add(currentLocationMarker);
    }

    setState(() {
      _markers = Set<Marker>.from(markers);
    });
  }

  void _navigateToOtherPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WarningPage(latitude: _currentPosition!.latitude, longitude: _currentPosition!.longitude)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa do Google'),
      ),
      body: (_currentPosition != null)
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _currentPosition!.latitude,
                  _currentPosition!.longitude,
                ),
                zoom: 15,
              ),
              markers: _markers,
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToOtherPage,
        child: Icon(Icons.warning),
        backgroundColor: Color(0xFFFfba619),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
