import 'package:flutter/material.dart';

import '../../domain/entities/accessory_entity.dart';

class AccessoryCard extends StatelessWidget {
  final AccessoryEntity accessory;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AccessoryCard({
    super.key,
    required this.accessory,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: scheme.tertiaryContainer,
          child: const Icon(Icons.shopping_bag_outlined),
        ),
        title: Text(
          accessory.name.isEmpty ? 'Sin nombre' : accessory.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          accessory.description.isEmpty ? 'Sin descripción' : accessory.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: scheme.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
