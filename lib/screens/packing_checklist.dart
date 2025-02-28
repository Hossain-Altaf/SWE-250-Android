import 'package:flutter/material.dart';

class PackingChecklistScreen extends StatelessWidget {
  const PackingChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Packing check")),
      body: const Center(child: Text("Packing check Screen")),
    );
  }
}