import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

/// **Model class**
///
/// Declared in abstract
///
/// Properties:
/// - tableKeys: List<String> **abstract**
/// - firestorePath: String **abstract**
/// - realtimePath: String **abstract**
/// - dataEmptiable: bool
///
/// Methods:
/// - setData(List<dynamic> data)
/// - getData()
/// - firestoreRead()
/// - firestoreWrite()
/// - realtimeRead()
/// - realtimeWrite()
/// - realtimeUpdate(String key)
/// - realtimeDelete(String key)
///
abstract class Model {
  /*  Protected properties section  */
  /// **Data that will be stored in Firestore collection**
  ///
  /// Writen in key-value pair
  ///
  /// Set data using `setData(List<dynamic> data)` method
  ///
  /// Get data using `getData()` method
  @protected
  final Map<String, dynamic> table = {};

  ///**Writable table keys**
  @protected
  abstract List<String> tableKeys;

  ///**Firestore collection path**
  @protected
  abstract String firestorePath;

  ///**Realtime Database ref path**
  @protected
  abstract String realtimePath;

  ///**Is table data**
  @protected
  bool dataEmptiable = false;

  @protected
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @protected
  FirebaseDatabase realtime = FirebaseDatabase.instance;

  CollectionReference fs() {
    return firestore.collection(firestorePath);
  }

  /// **Read data from Firestore collection**
  Future<QuerySnapshot> firestoreRead({
    String? subCollectionPath,
    List<dynamic>? where,
  }) async {
    if (subCollectionPath != null && subCollectionPath != "") {
      if (where != null && where.length == 3) {
        switch (where[1]) {
          case "==":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], isEqualTo: where[2])
                .get();
          case "<":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], isLessThan: where[2])
                .get();
          case "<=":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], isLessThanOrEqualTo: where[2])
                .get();
          case ">":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], isGreaterThan: where[2])
                .get();
          case ">=":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], isGreaterThanOrEqualTo: where[2])
                .get();
          case "null":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], isNull: where[2])
                .get();
          case "contains":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], arrayContains: where[2])
                .get();

          case "containsAny":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], arrayContainsAny: where[2])
                .get();
          case "whereIn":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], whereIn: where[2])
                .get();
          case "whereNotIn":
            return await firestore
                .collection("$firestorePath/$subCollectionPath")
                .where(where[0], whereNotIn: where[2])
                .get();
        }
      }
      return await firestore
          .collection("$firestorePath/$subCollectionPath")
          .get();
    }
    if (where != null && where.length == 3) {
      switch (where[1]) {
        case "==":
          return await firestore
              .collection(firestorePath)
              .where(where[0], isEqualTo: where[2])
              .get();
        case "<":
          return await firestore
              .collection(firestorePath)
              .where(where[0], isLessThan: where[2])
              .get();
        case "<=":
          return await firestore
              .collection(firestorePath)
              .where(where[0], isLessThanOrEqualTo: where[2])
              .get();
        case ">":
          return await firestore
              .collection(firestorePath)
              .where(where[0], isGreaterThan: where[2])
              .get();
        case ">=":
          return await firestore
              .collection(firestorePath)
              .where(where[0], isGreaterThanOrEqualTo: where[2])
              .get();
        case "null":
          return await firestore
              .collection(firestorePath)
              .where(where[0], isNull: where[2])
              .get();
        case "contains":
          return await firestore
              .collection(firestorePath)
              .where(where[0], arrayContains: where[2])
              .get();

        case "containsAny":
          return await firestore
              .collection(firestorePath)
              .where(where[0], arrayContainsAny: where[2])
              .get();
        case "whereIn":
          return await firestore
              .collection(firestorePath)
              .where(where[0], whereIn: where[2])
              .get();
        case "whereNotIn":
          return await firestore
              .collection(firestorePath)
              .where(where[0], whereNotIn: where[2])
              .get();
      }
    }
    return await firestore.collection(firestorePath).get();
  }

  /// **Write data to Firestore collection**
  Future<void> firestoreWrite(Map<String, dynamic> data, doc) async {
    firestore.collection(firestorePath).doc(doc).set(data);
  }

  DatabaseReference rt() {
    return realtime.ref(realtimePath);
  }

  /// **Read data from Realtime Database**
  Future<DatabaseEvent> realtimeRead() async {
    DatabaseReference ref = realtime.ref(realtimePath);
    return await ref.once();
  }

  /// **Write data to Realtime Database**
  Future<void> realtimeWrite() async {
    DatabaseReference ref = realtime.ref(realtimePath);
    return await ref.push().set(table);
  }

  /// **Update data in Realtime Database**
  Future<void> realtimeUpdate(String key) async {
    DatabaseReference ref = realtime.ref("$realtimePath/$key");
    return await ref.update(table);
  }

  /// **Delete data from Realtime Database**
  Future<void> realtimeDelete(String key) async {
    DatabaseReference ref = realtime.ref("$realtimePath/$key");
    return ref.remove();
  }
}
