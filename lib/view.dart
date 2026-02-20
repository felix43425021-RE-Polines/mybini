import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

abstract class View extends StatelessWidget {
  const View({super.key, this.firestoreData, this.realtimeData});
  final Map<String, Future<QuerySnapshot>>? firestoreData;
  final Map<String, Stream<DatabaseEvent>>? realtimeData;
}

abstract class StatefulView extends StatefulWidget {
  const StatefulView({super.key, this.firestoreData, this.realtimeData});
  final Map<String, Future<QuerySnapshot>>? firestoreData;
  final Map<String, Stream<DatabaseEvent>>? realtimeData;
}
