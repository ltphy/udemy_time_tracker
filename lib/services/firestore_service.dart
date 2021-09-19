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
    print(path);
    print(1);
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(path);
    print(2);
    if (queryBuilder != null) {
      // query the collection from path
      query = queryBuilder(query);
    }
    print(3);
    DateTime time = DateTime(2021);
    print(time.toIso8601String());
    final snapshots = query.snapshots();
    print(4);
    return snapshots.map((event) {
      final result = event.docs
          .map((e) {
            print(e.data());
            return builder(e.data());
          })
          .where((element) => element != null)
          .toList();
      print(5);
      print(result);
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
