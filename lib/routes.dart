import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/pages/jobs/job_updater_widget/job_updater_widget.dart';
import 'package:udemy_timer_tracker/pages/jobs/jobs.dart';
import 'package:udemy_timer_tracker/pages/jobs_entries/job_entries.dart';
import 'package:udemy_timer_tracker/pages/landing_page/landing_page.dart';

import 'pages/accounts/accounts.dart';
import 'pages/empty_screen/empty_screen.dart';
import 'pages/jobs/entries/entries.dart';
import 'pages/jobs/entry_page/entry_page.dart';

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
  static final List<Path> mainPaths = [
    Path(
        route: LandingPage.route,
        builder: (context, settings) {
          return Provider<NavigatorState>.value(
            value: Navigator.of(context),
            child: LandingPage(),
          );
        }),
    Path(
      route: JobUpdaterWidget.route,
      builder: (context, settings) {
        final args = settings.arguments as JobUpdateArgument;
        return Provider<NavigatorState>.value(
          value: Navigator.of(context),
          child: JobUpdaterWidget(
            database: args.database,
            job: args.job,
          ),
        );
      },
    ),
    Path(
      route: Entries.route,
      builder: (context, settings) {
        final args = settings.arguments as JobUpdateArgument;
        final job = args.job;
        if (job != null) {
          return Provider<NavigatorState>.value(
            value: Navigator.of(context),
            child: Entries(
              database: args.database,
              job: job,
            ),
          );
        }
        return EmptyScreen();
      },
    ),
  ];
  static final List<Path> paths = [
    Path(
      route: Account.route,
      builder: (context, settings) {
        return Account();
      },
    ),
    Path(
      route: JobsPage.route,
      builder: (context, settings) {
        return JobsPage();
      },
    ),
    Path(
      route: JobEntries.route,
      builder: (context, settings) {
        return JobEntries();
      },
    ),
  ];

  static Route<dynamic>? handleGenericPath(RouteSettings settings) {
    final String? name = settings.name;
    if (name == null) {
      return null;
    }
    List<String> routes = name.split('/');

    if (name.contains('entry') && routes.length == 2) {
      return MaterialPageRoute(
        builder: (context) {
          final args = settings.arguments as EntryArgument;
          return Provider<NavigatorState>.value(
            value: Navigator.of(context),
            child: EntryPage(
              database: args.database,
              entry: args.entry,
              job: args.job,
            ),
          );
        },
        settings: settings,
      );
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      if (path.route == settings.name) {
        print('name ${settings.name}');

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

  static Route<dynamic> onGenerateMainRoute(RouteSettings settings) {
    for (Path path in mainPaths) {
      if (path.route == settings.name) {
        print('name ${settings.name}');
        return MaterialPageRoute(
          builder: (context) {
            return path.builder(context, settings);
          },
          settings: settings,
        );
      }
    }
    Route<dynamic>? route = handleGenericPath(settings);
    if (route != null) return route;
    throw Exception('Invalid route ${settings.name}');
  }
}
