import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('You have logged in success'),
      ),
    );
  }
}

Future<void> main() async {
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    name: 'test',
    options: const FirebaseOptions(
      appId: '1:1058397123943:web:ead35679c1051c239febc2',
      messagingSenderId: '1058397123943',
      apiKey: 'AIzaSyAO4qHoY0_kaUZs96n1Uk-ioRo3qRb8ga4',
      projectId: 'flutterdevsdemo',
    ),
  );
  final firestore = FirebaseFirestore.instanceFor(app: app);

  runApp(MaterialApp(
      title: 'Firestore Example', home: MyHomePage(firestore: firestore)));
}

class MessageList extends StatelessWidget {
  const MessageList({required this.firestore});

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        final data = snapshot.data;
        if (!snapshot.hasData || data == null) return const Text('Loading...');
        final messageCount = data.docs.length;
        return ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            final document = data.docs[index];
            final dynamic message = document.get('message');
            return ListTile(
              title: Text(
                message != null ? message.toString() : '<No message retrieved>',
              ),
              subtitle: Text('Message ${index + 1} of $messageCount'),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.firestore});

  final FirebaseFirestore firestore;

  CollectionReference get messages => firestore.collection('messages');

  Future<void> _addMessage() async {
    await messages.add(<String, dynamic>{
      'message': 'Hello world!',
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Example'),
      ),
      body: MessageList(firestore: firestore),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
