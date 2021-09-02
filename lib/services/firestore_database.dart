import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>?> streamJobs();
}

class FirestoreDatabase extends Database {
  late final String uid;

  FirestoreDatabase({
    required this.uid,
  });

  @override
  Future<void> deleteJob(Job job) async {
    final path = APIPath.job(this.uid, 'jobabc');
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.delete();
  }

  @override
  Future<void> createJob(Job job) async {
    final path = APIPath.job(this.uid, 'job_abc');
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(job.toJson());
  }

  @override
  Stream<List<Job>?> streamJobs() {
    final path = APIPath.jobs(this.uid);
    final documentReference = FirebaseFirestore.instance.collection(path);
    final snapshots = documentReference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map((doc) => Job.fromJson(doc.data())).toList());
  }
}
