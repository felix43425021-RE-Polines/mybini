import 'package:flutter/material.dart';

abstract class StatelessView extends StatelessWidget {
  const StatelessView({super.key, this.firestoreData, this.realtimeData});
  final dynamic firestoreData;
  final dynamic realtimeData;
}

abstract class StatefulView extends StatefulWidget {
  const StatefulView({super.key, this.firestoreData, this.realtimeData});
  final dynamic firestoreData;
  final dynamic realtimeData;
}
