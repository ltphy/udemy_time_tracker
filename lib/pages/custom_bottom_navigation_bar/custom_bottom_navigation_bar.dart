import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/provider/select_bottom_navigation_provider.dart';

import 'tab_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectTab}) : super(key: key);
  final ValueSetter<int> selectTab;

  BottomNavigationBarItem buildBottomBarItem(
      NavigationItemData navigationItemData) {
    return BottomNavigationBarItem(
      icon: Icon(navigationItemData.iconData),
      label: navigationItemData.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectBottomNavigationProvider>(
      builder: (context, selectBottomNavigationProvider, _) {
        return BottomNavigationBar(
          currentIndex: selectBottomNavigationProvider.routeIndex,
          onTap: selectTab,
          items: [
            for (int i = 0;
                i < NavigationItemData.navigationItemDataList.length;
                i++)
              buildBottomBarItem(NavigationItemData.navigationItemDataList[i])
          ],
        );
      },
    );
  }
}
