import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/services/api_path.dart';
import 'package:udemy_timer_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> updateJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>?> streamJobs();

  Future<void> updateEntry(Entry entry);
  Future<void> deleteEntry(Job job);
  Stream<List<Entry>?> streamEntries();
}

class FirestoreDatabase extends Database {
  late final String uid;
  final FirestoreService _service = FirestoreService.instance;

  FirestoreDatabase({
    required this.uid,
  });

  @override
  Future<void> deleteJob(Job job) async => await _service.removeData(
          path: APIPath.job(
        this.uid,
        job.id,
      ));

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

  @override
  Future<void> deleteEntry(Job job) {
    // TODO: implement deleteEntry
    throw UnimplementedError();
  }

  @override
  Stream<List<Entry>?> streamEntries() {
    // TODO: implement streamEntries
    throw UnimplementedError();
  }

  @override
  Future<void> updateEntry(Entry entry) {
    // TODO: implement updateEntry
    throw UnimplementedError();
  }
}
