import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;

  const DetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tienda #$index'),
      ),
      body: const Center(
        child: Text('La informacion de la tienda aparecera aqui.'),
      ),
    );
  }
}
