import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GameRoom'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  bool hasLockers = false;
  bool hasWash = false;
  bool hasLight = false;
  bool hasParking = false;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Ввод данных"),
      ),
      body: Center(
        child: SizedBox(
          width: 380,
          child: ListView(
            children: [
              Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text('Загрузить фотографию')),
                  if (imageUrl != null) Image.network(imageUrl!),
                  const TextField(
                    decoration: InputDecoration(hintText: "Адрес"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Время конца игры"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Время начала игры"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Длина поля"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Ширина поля"),
                  ),
                  //gameId
                  //image picker
                  const SizedBox(
                    height: 20,
                  ),
                  CheckboxListTile(
                      title: const Text(
                        'Есть раздевалка',
                      ),
                      value: hasLockers,
                      onChanged: (val) {
                        setState(() {
                          hasLockers = val ?? false;
                        });
                      }),
                  CheckboxListTile(
                      title: const Text(
                        'Есть освещение',
                      ),
                      value: hasLight,
                      onChanged: (val) {
                        setState(() {
                          hasLight = val ?? false;
                        });
                      }),
                  CheckboxListTile(
                      title: const Text(
                        'Есть паркинг',
                      ),
                      value: hasParking,
                      onChanged: (val) {
                        setState(() {
                          hasParking = val ?? false;
                        });
                      }),
                  CheckboxListTile(
                      title: const Text(
                        'Есть душ',
                      ),
                      value: hasWash,
                      onChanged: (val) {
                        setState(() {
                          hasWash = val ?? false;
                        });
                      }),
                  const TextField(
                    decoration:
                        InputDecoration(hintText: "Ссылка на карту 2Gis"),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: "Максимальное кол-во игроков"),
                  ),
                  //
                  // /список //игроков //пока //пустой
                  //
                  const TextField(
                    decoration: InputDecoration(hintText: "Цена"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Рейтинг"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Здание"),
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Название"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    XFile? image;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        var snapshot = await storage
            .ref()
            .child("folderName/imageName")
            .putData(await image.readAsBytes());

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('no path');
      }
    } else {
      const Text("grant permission");
    }
  }
}
