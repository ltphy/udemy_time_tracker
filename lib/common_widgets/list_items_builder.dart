import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/common_widgets/empty_container.dart';

typedef ItemWidgetBuilder<T> = Widget Function(T value);

class ListItemsBuilder<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemWidgetBuilder;
  final AsyncSnapshot<List<T>?> snapshot;

  const ListItemsBuilder({
    Key? key,
    required this.itemWidgetBuilder,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // custom widget
    if (snapshot.hasData) {
      final List<T>? data = snapshot.data;
      if (data != null && data.isNotEmpty) {
        return buildList(data);
      }
      return EmptyContainer(
        content: 'Add new item to attach',
        title: 'No Item',
      );
    }
    if (snapshot.hasError) {
      return EmptyContainer(
        content: 'Can\'t load item right now',
        title: 'Something when wrong',
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildList(List<T> items) {
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) => itemWidgetBuilder(items[index]),
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
