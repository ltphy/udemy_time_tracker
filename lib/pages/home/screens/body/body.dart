import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/common_widgets/custom_progress_indicator.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/provider/selected_job_provider.dart';
import 'package:udemy_timer_tracker/services/validators.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class _BodyState extends State<Body> with JobValidators {
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _ratePerHourFocusNode = new FocusNode();
  late String? _defaultName;
  late double? _defaultRatePerHour;

  GlobalKey<FormState> get _formKey =>
      Provider.of<SelectedJobProvider>(context, listen: false).formKey;

  @override
  void didChangeDependencies() {
    Job job = context.read<SelectedJobProvider>().job;
    _defaultName = job.name;
    _defaultRatePerHour = job.ratePerHour;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _ratePerHourFocusNode.dispose();
    super.dispose();
  }

  void _nameEditingComplete() {
    FocusScope.of(context).requestFocus(_ratePerHourFocusNode);
  }

  Future<void> updateJob() async {
    try {
      await context.read<SelectedJobProvider>().updateJobInDatabase();
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: context.watch<SelectedJobProvider>().loading
                ? Center(child: CustomProgressIndicator())
                : Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: TextFormField(
                            onSaved: (value) => context
                                .read<SelectedJobProvider>()
                                .updateJob(name: value),
                            initialValue: _defaultName,
                            focusNode: _nameFocusNode,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              border: UnderlineInputBorder(),
                            ),
                            validator: validateName,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: _nameEditingComplete,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: TextFormField(
                            initialValue: _defaultRatePerHour != null
                                ? '$_defaultRatePerHour'
                                : null,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (value) => context
                                .read<SelectedJobProvider>()
                                .updateJob(
                                    ratePerHour: value != null
                                        ? double.tryParse(value)
                                        : null),
                            keyboardType: TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            focusNode: _ratePerHourFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Rate Per Hour',
                              border: UnderlineInputBorder(),
                            ),
                            // validator: model.validatePassword,
                            onEditingComplete: updateJob,
                            validator: validateRatePerHour,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
