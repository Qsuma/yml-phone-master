import 'package:flutter/material.dart';

class Alarm {
  void showAlarm(BuildContext context, String message, String headline) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white70.withOpacity(1),
            title: Center(
                child: Text(
              headline,
              style: const TextStyle(color: Colors.red),
            )),
            content: Text(
              message,
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  child: const Center(
                    child: Text(
                      'Ok',
                      style: TextStyle(fontSize: 17),
                    ),
                  ))
            ],
          );
        });
  }
}
