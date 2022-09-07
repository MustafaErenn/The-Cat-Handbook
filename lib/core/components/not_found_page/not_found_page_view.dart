import 'package:flutter/material.dart';

class NotFoundPageView extends StatelessWidget {
  const NotFoundPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Not Found"),
      ),
      body: const Center(
        child: Text("Not Found :("),
      ),
    );
  }
}
