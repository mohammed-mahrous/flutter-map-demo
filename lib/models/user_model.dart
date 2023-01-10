import 'package:latlong2/latlong.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.age,
    required this.location,
  });

  final String name;
  final String id;
  final String email;
  final int age;
  final LatLng location;
}
