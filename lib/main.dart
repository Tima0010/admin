import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gameroom_admin/send_model.dart';
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
      theme: ThemeData(primarySwatch: Colors.green),
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

  final address = TextEditingController();
  final endTime = TextEditingController();
  final startTime = TextEditingController();
  final fieldHeight = TextEditingController();
  final fieldWidth = TextEditingController();
  final gameId = TextEditingController();
  final mapUrl = TextEditingController();
  final maxPlayersPerTeam = TextEditingController();
  final price = TextEditingController();
  final rating = TextEditingController();
  final room = TextEditingController();
  final title = TextEditingController();
  bool hasLockers = false;
  bool hasWash = false;
  bool hasLight = false;
  bool hasParking = false;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Ввод данных"),
      ),
      body: Center(
        child: SizedBox(
          width: 380,
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      await uploadImage();
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      'Загрузить фотографию',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (imageUrl != null) Image.network(imageUrl!),
                  const SizedBox(height: 10),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(hintText: "Адрес"),
                  ),

                  TextField(
                    decoration: const InputDecoration(
                      hintText: "2022-12-31 12:00",
                      labelText: "Время конца игры",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    inputFormatters: [
                      TextInputMask(mask: "9999-99-99 99:99", reverse: false),
                    ],
                    controller: endTime,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "2022-12-31 12:00",
                      labelText: "Время начала игры",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    inputFormatters: [
                      TextInputMask(mask: "9999-99-99 99:99", reverse: false),
                    ],
                    controller: startTime,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Длина поля"),
                    controller: fieldHeight,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Ширина поля"),
                    controller: fieldWidth,
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
                      checkColor: Colors.white,
                      activeColor: Colors.green,
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
                      checkColor: Colors.white,
                      activeColor: Colors.green,
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
                      checkColor: Colors.white,
                      activeColor: Colors.green,
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
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: hasWash,
                      onChanged: (val) {
                        setState(() {
                          hasWash = val ?? false;
                        });
                      }),
                  TextField(
                    decoration:
                        const InputDecoration(hintText: "Ссылка на карту 2Gis"),
                    controller: mapUrl,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        hintText: "Максимальное кол-во игроков"),
                    controller: maxPlayersPerTeam,
                  ),
                  //
                  // /список //игроков //пока //пустой
                  //
                  TextField(
                    decoration: const InputDecoration(hintText: "Цена"),
                    controller: price,
                  ),

                  TextField(
                    decoration: const InputDecoration(hintText: "Рейтинг"),
                    controller: rating,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Здание"),
                    controller: room,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: "Название"),
                    controller: title,
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      final game = GameModel(
                          address: address.text,
                          endTime: Timestamp.fromDate(
                              DateTime.parse('${endTime.text}:00')),
                          startTime: Timestamp.fromDate(
                              DateTime.parse('${startTime.text}:00')),
                          fieldHeight: num.parse(fieldHeight.text),
                          fieldWidth: num.parse(fieldWidth.text),
                          gameId: '${title.text}: ${startTime.text}',
                          imageUrl: imageUrl!,
                          hasLockers: hasLockers,
                          hasLights: hasLight,
                          hasParking: hasParking,
                          hasWash: hasWash,
                          mapUrl: mapUrl.text,
                          maxPlayersPerTeam: num.parse(maxPlayersPerTeam.text),
                          players: [],
                          price: num.parse(price.text),
                          rating: 0,
                          room: room.text,
                          title: title.text);

                      FirebaseFirestore.instance
                          .collection('Fields')
                          .doc(game.gameId)
                          .set(game.toJson())
                          .then((value) => showDialog(
                              context: context,
                              builder: (context) {
                                return const Text(
                                    'Данные успешно отправились, Ерлан красавчик');
                              }))
                          .catchError((e) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Text(
                                  'Ошибка отправки Данных, напиши мне Ерлан');
                            });
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Отправить",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
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
      } else {}
    } else {
      const Text("grant permission");
    }
  }
}
