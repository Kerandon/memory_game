
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/Cloud.png')
            )
        ),
        child: const Center(child: CircularProgressIndicator()));
  }
}