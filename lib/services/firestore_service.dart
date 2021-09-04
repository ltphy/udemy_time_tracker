import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static FirestoreService get instance => FirestoreService._();

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(data);
  }

  Stream<List<T>?> streamCollections<T>(
      {required String path, required T builder(Map<String, dynamic> value)}) {
    final documentReference = FirebaseFirestore.instance.collection(path);

    final snapshots = documentReference.snapshots();
    return snapshots.map(
        (snapshot) => snapshot.docs.map((doc) => builder(doc.data())).toList());
  }
}
