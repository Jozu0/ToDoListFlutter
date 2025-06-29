import 'package:flutter/material.dart';


class MarginWrapper extends StatelessWidget {
  final Widget child;

  const MarginWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20), // margin global horizontal
      child: child,
    );
  }
}