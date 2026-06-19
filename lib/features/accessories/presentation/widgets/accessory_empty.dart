import 'package:flutter/material.dart';

import '../../../../shared/widgets/empty_state_widget.dart';

class AccessoryEmpty extends StatelessWidget {
  const AccessoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const EmptyStateWidget(
      icon: Icons.shopping_bag_outlined,
      message: 'No hay accesorios registrados',
    );
  }
}
