import 'package:flutter/material.dart';

class Drdetails extends StatelessWidget {
  final dynamic doctor;
  const Drdetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            GridItem(title: 'Item 1'),
            GridItem(title: 'Item 2'),
            GridItem(title: 'Item 3'),
          ],
        )
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  const GridItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[100],
      child: Center(
        child: Text(title),
      ),
    );
  }
}
