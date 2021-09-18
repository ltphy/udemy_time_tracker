import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/job_updater_widget/job_updater_widget.dart';
import 'package:udemy_timer_tracker/pages/landing_page/landing_page.dart';

import 'pages/empty_screen/empty_screen.dart';
import 'pages/entries/entries.dart';

typedef PathWidgetBuilder = Widget Function(
    BuildContext context, RouteSettings settings);

class Path {
  final String route;
  final PathWidgetBuilder builder;

  Path({
    required this.route,
    required this.builder,
  });
}

class RouteConfiguration {
  static final List<Path> paths = [
    Path(
      route: JobUpdaterWidget.route,
      builder: (context, settings) {
        final args = settings.arguments as JobUpdateArgument;
        return JobUpdaterWidget(
          database: args.database,
          job: args.job,
        );
      },
    ),
    Path(
      route: Entries.route,
      builder: (context, settings) {
        final args = settings.arguments as JobUpdateArgument;
        final job = args.job;
        if (job != null) {
          return Entries(
            database: args.database,
            job: job,
          );
        }
        return EmptyScreen();
      },
    ),
    Path(
      route: LandingPage.route,
      builder: (context, settings) {
        return LandingPage();
      },
    ),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      if (path.route == settings.name) {
        return MaterialPageRoute(
          builder: (context) {
            return path.builder(context, settings);
          },
          settings: settings,
        );
      }
    }
    throw Exception('Invalid route ${settings.name}');
  }
}
