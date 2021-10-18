import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/accounts/accounts.dart';
import 'package:udemy_timer_tracker/pages/jobs/jobs.dart';
import 'package:udemy_timer_tracker/pages/jobs_entries/job_entries.dart';

enum TabItem { Jobs, Entries, Account }

class NavigationItemData {
  final String title;
  final IconData iconData;
  final String routeName;

  NavigationItemData({
    required this.title,
    required this.iconData,
    required this.routeName,
  });

  static List<NavigationItemData> navigationItemDataList = [
    NavigationItemData(
        title: 'Jobs', iconData: Icons.work, routeName: JobsPage.route),
    NavigationItemData(
        title: 'Entries', iconData: Icons.work, routeName: JobEntries.route),
    NavigationItemData(
        title: 'Account', iconData: Icons.work, routeName: Account.route),
  ];
}
