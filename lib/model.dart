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
  Future<QuerySnapshot> firestoreRead({String? subCollectionPath}) async {
    if (subCollectionPath != null && subCollectionPath != "") {
      return await firestore
          .collection("$firestorePath/$subCollectionPath")
          .get();
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
