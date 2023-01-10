import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_demo/models/user_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class UserMapPage extends StatefulWidget {
  const UserMapPage({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  _UserMapPageState createState() => _UserMapPageState();
}

class _UserMapPageState extends State<UserMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.name} location"),
      ),
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: 0.2,
        renderPanelSheet: false,
        panel: UserInfoPanel(user: widget.user),
        body: FlutterMap(
          options: MapOptions(
            center: widget.user.location,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: widget.user.location,
                  builder: (context) => const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 30,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserInfoPanel extends StatelessWidget {
  const UserInfoPanel({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]),
      margin: const EdgeInsets.all(24.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "User Info",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name: ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Email: ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Age: ",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "${user.age}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
