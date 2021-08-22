import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:udemy_timer_tracker/services/sign_in_services.dart';

class DialogService {
  // final DialogService _instance = DialogService._();

  DialogService._();

  static final DialogService instance = DialogService._();

  Future<bool?> showMyDialog(
    BuildContext context, {
    String? title,
    required String message,
    String? cancelActionText,
    required String defaultActionText,
  }) async {
    return showDialog<bool>(
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Center(child: Text(title)) : null,
          content: Text(message),
          actions: <Widget>[
            if (cancelActionText != null)
              TextButton(
                child: Text(cancelActionText),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            TextButton(
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
      context: context,
      barrierDismissible: false,
    );
  }

  Future<bool?> showExceptionDialog(
      BuildContext context, Exception exception) async {
    if (exception is FirebaseAuthException &&
        exception.code == describeEnum(ERROR_CODE.ERROR_ABORTED_BY_USER)) {
      return false;
    }
    return await this.showMyDialog(
      context,
      title: 'Sign In Failed',
      message: _handleMessage(exception),
      defaultActionText: 'OK',
    );
  }

  String _handleMessage(Exception exception) {
    if (exception is FirebaseAuthException) {
      return exception.message.toString();
    }
    return exception.toString();
  }
}
