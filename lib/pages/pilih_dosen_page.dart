import 'package:flutter/material.dart';

class PilihDosenPage extends StatelessWidget {
  const PilihDosenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Dosen Pembimbing")),
      body: const Center(child: Text("Halaman Pilih Dosen")),
    );
  }
}
