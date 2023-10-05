import 'package:flutter/material.dart';

class DialogUtils {
  static List<String> items = ["Customers", "Staff Members"];
  static Future<String?> showStringListDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send to:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: items
                  .map(
                    (item) => GestureDetector(
                      onTap: () => Navigator.of(context).pop(item),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(item),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
