import 'package:flutter_map_demo/models/user_model.dart';
import 'package:flutter_map_demo/services/model_factory.dart';
import 'package:latlong2/latlong.dart';

class UserModelFactory extends ModelFactory {
  @override
  UserModel generateFake() {
    return UserModel(
      name: "${faker.person.firstName()} ${faker.person.lastName()}".trim(),
      id: createFakeUuid(),
      email: faker.internet.email(),
      age: faker.randomGenerator.integer(35, min: 18),
      location: LatLng(faker.geo.latitude(), faker.geo.longitude()),
    );
  }

  @override
  List<UserModel> generateFakeList({required int length}) {
    return List<UserModel>.generate(length, (index) => generateFake());
  }
}
