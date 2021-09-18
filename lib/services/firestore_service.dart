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

  Future<void> removeData({required String path}) async {
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.delete();
  }

  // create builder for queryBuilder
  Stream<List<T>?> streamCollections<T>({
    // path
    required String path,
    // builder for extract object
    required T Function(Map<String, dynamic> value) builder,
    //
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? compare,
  }) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      // query the collection from path
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((event) {
      final result = event.docs
          .map((e) => builder(e.data()))
          .where((element) => element != null)
          .toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required T Function(Map<String, dynamic>? value) builder,
    required String path,
  }) {
    final document = FirebaseFirestore.instance.doc(path);
    final snapshots = document.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data()))
        .where((value) => value != null);
  }
}
