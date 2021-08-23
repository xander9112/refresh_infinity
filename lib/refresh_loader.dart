import 'package:flutter/material.dart';

class RefreshLoader extends StatelessWidget {
  const RefreshLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
