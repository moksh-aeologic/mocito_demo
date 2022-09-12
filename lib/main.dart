import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/album.dart';
import 'services/album_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final app = await Firebase.initializeApp(
  //   // name: 'test',
  //   options: const FirebaseOptions(
  //     appId: '1:1058397123943:web:ead35679c1051c239febc2',
  //     messagingSenderId: '1058397123943',
  //     apiKey: 'AIzaSyAO4qHoY0_kaUZs96n1Uk-ioRo3qRb8ga4',
  //     projectId: 'flutterdevsdemo',
  //   ),
  // );
  // final firestore = FirebaseFirestore.instanceFor(app: app);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example')),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
