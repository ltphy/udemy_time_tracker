import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/common_widgets/date_time_picker.dart';
import 'package:udemy_timer_tracker/provider/selected_entry_provider.dart';
import 'package:tuple/tuple.dart';
import 'package:udemy_timer_tracker/services/format.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  Widget buildStart() {
    return Selector<SelectedEntryProvider, Tuple2<DateTime, TimeOfDay>>(
      builder: (BuildContext context, value, _) {
        return DateTimePicker(
          onSelectedTime: (TimeOfDay value) => context
              .read<SelectedEntryProvider>()
              .updateEntry(startTime: value),
          labelText: 'Start',
          selectedDate: value.item1,
          onSelectedDate: (DateTime value) => context
              .read<SelectedEntryProvider>()
              .updateEntry(startDate: value),
          selectedTime: value.item2,
        );
      },
      selector: (_, selectedEntryProvider) => Tuple2(
          selectedEntryProvider.startDate!, selectedEntryProvider.startTime!),
    );
  }

  Widget buildEnd() {
    return Selector<SelectedEntryProvider, Tuple2<DateTime, TimeOfDay>>(
      builder: (BuildContext context, value, _) {
        return DateTimePicker(
          onSelectedTime: (TimeOfDay value) => context
              .read<SelectedEntryProvider>()
              .updateEntry(startTime: value),
          labelText: 'End',
          selectedDate: value.item1,
          onSelectedDate: (DateTime value) => context
              .read<SelectedEntryProvider>()
              .updateEntry(startDate: value),
          selectedTime: value.item2,
        );
      },
      selector: (_, selectedEntryProvider) => Tuple2(
          selectedEntryProvider.endDate!, selectedEntryProvider.endTime!),
    );
  }

  Widget buildDuration() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          Format.instance
              .hours(context.watch<SelectedEntryProvider>().duration),
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        children: [
          this.buildStart(),
          this.buildEnd(),
          SizedBox(
            height: 10,
          ),
          this.buildDuration(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
