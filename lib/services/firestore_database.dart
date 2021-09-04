import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/services/api_path.dart';
import 'package:udemy_timer_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> updateJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>?> streamJobs();
}

class FirestoreDatabase extends Database {
  late final String uid;
  final FirestoreService _service = FirestoreService.instance;

  FirestoreDatabase({
    required this.uid,
  });

  @override
  Future<void> deleteJob(Job job) async {
    final path = APIPath.job(this.uid, job.id);
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.delete();
  }

  @override
  Future<void> updateJob(Job job) async => await _service.setData(
        path: APIPath.job(this.uid, job.id),
        data: job.toJson(),
      );

  @override
  Stream<List<Job>?> streamJobs() => _service.streamCollections(
        path: APIPath.jobs(this.uid),
        builder: (value) => Job.fromJson(value),
      );
}
