import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/pages/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:udemy_timer_tracker/pages/custom_bottom_navigation_bar/tab_item.dart';
import 'package:udemy_timer_tracker/pages/jobs/jobs.dart';
import 'package:udemy_timer_tracker/pages/landing_page/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/provider/select_bottom_navigation_provider.dart';

import '../../routes.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  void onTabItem(BuildContext context, int index) {
    if (index == context.read<SelectBottomNavigationProvider>().routeIndex) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } else {
      if (navigatorKey.currentState!.canPop()) {
        navigatorKey.currentState!.popUntil((route) => route.isFirst);
      }
      // pop the current main and replace with the new route
      print(1);
      navigatorKey.currentState!.popAndPushNamed(
          NavigationItemData.navigationItemDataList[index].routeName);
      print(2);
      context
          .read<SelectBottomNavigationProvider>()
          .selectBottomNavigation(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // is first route in current Tab pop out
        // if not first route stop here
        return !await navigatorKey.currentState!.maybePop();
      },
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: JobsPage.route,
          onGenerateRoute: RouteConfiguration.onGenerateRoute,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectTab: (index) => onTabItem(context, index),
        ),
      ),
    );
  }
}
