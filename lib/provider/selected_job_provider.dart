import 'package:flutter/cupertino.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class SelectedJobProvider extends ChangeNotifier {
  Job job;
  late final Database database;
  bool loading;
  final formKey = GlobalKey<FormState>();

  SelectedJobProvider({
    required this.job,
    required this.database,
    this.loading = false,
  });

  Future<void> updateJobInDatabase() async {
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        this.updateWith(loading: true);
        await this.database.updateJob(this.job);
      }
    } catch (error) {
      rethrow;
    } finally {
      this.updateWith(loading: false);
    }
  }

  void updateWith({bool? loading, Job? job}) {
    this.loading = loading ?? this.loading;
    this.job = job ?? this.job;
    notifyListeners();
  }

  void updateJob({String? name, double? ratePerHour}) {
    this.job.name = name ?? this.job.name;
    this.job.ratePerHour = ratePerHour ?? this.job.ratePerHour;
  }
}
