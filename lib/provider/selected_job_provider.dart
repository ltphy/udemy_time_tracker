import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';

class SelectedJobProvider {
  late final Job? job;

  SelectedJobProvider({this.job});

  void updateJob(Job job) {
    this.job = job;
  }
}
