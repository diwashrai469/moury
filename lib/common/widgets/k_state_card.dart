import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? color;

  const StatCard(
      {required this.children,
      this.color,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      margin: const EdgeInsets.only(right: 25),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: children),
      ),
    );
  }
}
