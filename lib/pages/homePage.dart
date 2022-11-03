import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  GoogleMapController? mapController;
  Set<Marker> markers = new Set<Marker>();
  double lat = -26.5967282;
  double long = -53.5197105;

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
}
