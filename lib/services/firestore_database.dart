import 'package:udemy_timer_tracker/model/entry/entry.dart';
import 'package:udemy_timer_tracker/model/job.dart';
import 'package:udemy_timer_tracker/services/api_path.dart';
import 'package:udemy_timer_tracker/services/firestore_service.dart';

abstract class Database {
  Future<void> updateJob(Job job);

  Future<void> deleteJob(Job job);

  Stream<List<Job>?> streamJobs();

  Future<void> updateEntry(Entry entry);

  Future<void> deleteEntry(Entry entry);

  Stream<List<Entry>?> streamEntries({Job? job});
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
  Future<void> deleteEntry(Entry entry) async =>
      await _service.removeData(path: APIPath.entry(this.uid, entry.id));

  @override
  Stream<List<Entry>?> streamEntries({Job? job}) => _service.streamCollections(
        path: APIPath.entries(this.uid),
        builder: (value) => Entry.fromJson(value),
        queryBuilder: job != null
            ? (query) => query.where(
                  'jobId',
                  isEqualTo: job.id,
                )
            : null,
        compare: (Entry lhs, Entry rhs) => lhs.start.compareTo(rhs.start),
      );

  @override
  Future<void> updateEntry(Entry entry) async => await _service.setData(
        path: APIPath.entry(this.uid, entry.id),
        data: entry.toJson(),
      );
}
