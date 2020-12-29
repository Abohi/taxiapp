import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hitchyke/models/coordinates_model.dart';
import 'package:hitchyke/models/placemodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyC3_X0C2eOdnslq8X9NLA68Xe964kgA2aw";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.post(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<List<Place>> getLocationPlaceData(String input) async {
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String components = 'country:ng';

    String request =
        '$baseURL?input=$input&key=$apiKey&components=$components&type=$type';
    http.Response response = await http.post(request);
    Map values = jsonDecode(response.body);
    var predictions = values["predictions"];
    List<Place> _displayResults = [];

    for (var i = 0; i < predictions.length; i++) {
      String name = predictions[i]['description'];
      String placeId = predictions[i]['place_id'];

      _displayResults.add(Place(placeName: name, placeId: placeId));
    }
    return _displayResults;
  }

  Future<Coordinates_Model> getLatitudeandLongitude(String _placeId) async {
    String request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$_placeId&fields=geometry&key=$apiKey';
    http.Response response = await http.post(request);
    Map values = jsonDecode(response.body);
    var predictions = values["result"]["geometry"]["location"];
    Coordinates_Model placeLatitude = Coordinates_Model(
        placeLatitude: predictions["lat"], placeLongitude: predictions["lng"]);
    return placeLatitude;
  }
}
