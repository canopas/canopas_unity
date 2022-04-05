import 'package:flutter/material.dart';

void showErrorBanner(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
        content: Text(message,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        actions: [
          TextButton(
              child: const Text(
                'OK',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                Navigator.pop(context);
              })
        ]),
  );
}
