import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreDatabase = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>?>(
      stream: firestoreDatabase.streamJobs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          List<Job>? jobs = snapshot.data;
          if (jobs != null) {
            return Container(
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      jobs[index].name ?? '',
                    ),
                    trailing: Icon(Icons.arrow_right),
                  );
                },
                itemCount: jobs.length,
              ),
            );
          }
          return SizedBox();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
