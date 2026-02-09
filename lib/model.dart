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

  /// **Set data inside table property**
  void setData(List<dynamic> data) {
    for (int i = 0; i < tableKeys.length; i++) {
      if (i < data.length) {
        table[tableKeys[i]] = data[i];
      } else {
        if (dataEmptiable) {
          table[tableKeys[i]] = "";
        } else {
          throw FormatException("${tableKeys[i]} data cannot be emptied.");
        }
      }
    }
  }

  /// **Get data inside table property**
  ///
  /// Main purpose is for debugging process
  ///
  /// Return [Map<String, dynamic>]
  Map<String, dynamic> getData() {
    return table;
  }

  /// **Read data from Firestore collection**
  void firestoreRead(Function callback) async {
    QuerySnapshot querySnapshot = await firestore
        .collection(firestorePath)
        .get();
    Map<String, dynamic> result = {};

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      result[doc.id] = doc.data() as Map<String, dynamic>;
    }

    callback(result);
  }

  /// **Write data to Firestore collection**
  Future<DocumentReference> firestoreWrite() async {
    return firestore.collection(firestorePath).add(table).then((docRef) {
      return docRef;
    });
  }

  /// **Read data from Realtime Database**
  Future<DatabaseEvent> realtimeRead() async {
    DatabaseReference ref = realtime.ref(realtimePath);
    return ref.once();
  }

  /// **Write data to Realtime Database**
  Future<void> realtimeWrite() async {
    DatabaseReference ref = realtime.ref(realtimePath);
    return ref.push().set(table);
  }

  /// **Update data in Realtime Database**
  Future<void> realtimeUpdate(String key) async {
    DatabaseReference ref = realtime.ref("$realtimePath/$key");
    return ref.update(table);
  }

  /// **Delete data from Realtime Database**
  Future<void> realtimeDelete(String key) async {
    DatabaseReference ref = realtime.ref("$realtimePath/$key");
    return ref.remove();
  }
}
