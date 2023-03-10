import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Second screen'),
          const SizedBox(
            height: 8,
          ),
          MaterialButton(
            onPressed: () {},
            child: const Text('Go to second screen'),
          )
        ],
      ),
    );
  }
}
