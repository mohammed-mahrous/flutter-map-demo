import 'package:flutter/material.dart';
import 'package:flutter_map_demo/models/user_model.dart';
import 'package:flutter_map_demo/providers/user_model_provider.dart';
import 'package:flutter_map_demo/services/user_model_factory.dart';
import 'package:flutter_map_demo/user_map_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserModelProvider(
            UserModelFactory(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void didChangeDependencies() {
    context.read<UserModelProvider>().init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final users = context.select((UserModelProvider p) => p.users);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List"),
      ),
      body: users.isEmpty
          ? const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : RefreshIndicator(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return UserCardWidget(user: user);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: users.length,
                ),
              ),
              onRefresh: () async {
                context.read<UserModelProvider>().resetUsers();
              },
            ),
    );
  }
}

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey<String>(user.id),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Name: "),
                Text(user.name),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email: "),
                Text(user.email),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Age: "),
                Text("${user.age}"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    final route = MaterialPageRoute(
                      builder: (context) => UserMapPage(user: user),
                    );
                    Navigator.of(context).push(route);
                  },
                  child: const Text("show location on map")),
            ),
          ],
        ),
      ),
    );
  }
}
