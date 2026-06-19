import 'package:flutter/material.dart';

import '../../domain/entities/accessory_entity.dart';

class AccessoryDetailPage extends StatelessWidget {
  final AccessoryEntity accessory;

  const AccessoryDetailPage({super.key, required this.accessory});

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
              backgroundColor: scheme.tertiaryContainer,
              child: const Icon(Icons.shopping_bag, size: 48),
            ),
            const SizedBox(height: 24),
            _row('ID', accessory.id.toString()),
            _row('Nombre', accessory.name.isEmpty ? '—' : accessory.name),
            const SizedBox(height: 8),
            const Text(
              'Descripción',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(accessory.description.isEmpty ? '—' : accessory.description),
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
