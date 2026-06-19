import 'package:flutter/material.dart';

import '../../domain/entities/pet_entity.dart';

class PetDetailPage extends StatelessWidget {
  final PetEntity pet;

  const PetDetailPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: scheme.primaryContainer,
              child: const Icon(Icons.pets, size: 48),
            ),
            const SizedBox(height: 24),
            _row('ID', pet.id.toString()),
            _row('Nombre', pet.name.isEmpty ? '—' : pet.name),
            _row('Raza', pet.raza.isEmpty ? '—' : pet.raza),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }
}
