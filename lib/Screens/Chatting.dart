import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 32),
            SizedBox(height: 50),
            MaterialButton(
              color: Colors.amber,
              minWidth: 200,
              height: 50,
              onPressed: () {},
              child: Text('Click'),
            ),
          ],
        ),
      ),
    );
  }
}
