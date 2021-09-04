import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:udemy_timer_tracker/pages/sign_in_page/model/job.dart';
import 'package:udemy_timer_tracker/services/firestore_database.dart';
import 'package:provider/provider.dart';
import 'package:udemy_timer_tracker/services/validators.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with JobValidators {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _ratePerHourController = new TextEditingController();
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _ratePerHourFocusNode = new FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _ratePerHourController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _nameEditingComplete() {
    FocusScope.of(context).requestFocus(_ratePerHourFocusNode);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> updateJob() async {
    try {
      print('validated');

      if (_formKey.currentState!.validate()) {
        print('validated');
        String name = _nameController.text;
        double ratePerHour = double.parse(_ratePerHourController.text);
        Job job = Job(name: name, ratePerHour: ratePerHour);
        await context.read<Database>().createJob(job);
        Navigator.of(context).pop();
      }
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: TextFormField(
                      focusNode: _nameFocusNode,
                      controller: _nameController,
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      controller: _ratePerHourController,
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
