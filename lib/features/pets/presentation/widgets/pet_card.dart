import 'package:flutter/material.dart';

import '../../domain/entities/pet_entity.dart';

class PetCard extends StatelessWidget {
  final PetEntity pet;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PetCard({
    super.key,
    required this.pet,
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
          backgroundColor: scheme.primaryContainer,
          child: const Icon(Icons.pets),
        ),
        title: Text(
          pet.name.isEmpty ? 'Sin nombre' : pet.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(pet.raza.isEmpty ? 'Sin raza' : pet.raza),
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
