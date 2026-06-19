import 'package:flutter/material.dart';

import '../../../../shared/widgets/empty_state_widget.dart';

class PetEmpty extends StatelessWidget {
  const PetEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon: Icons.pets_outlined,
      message: 'No hay mascotas registradas',
    );
  }
}
