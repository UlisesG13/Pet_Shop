import 'package:flutter/material.dart';

import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class PetForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController razaController;

  const PetForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.razaController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: nameController,
            label: 'Nombre',
            icon: Icons.badge_outlined,
            validator: (v) => Validators.required(v, field: 'El nombre'),
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: razaController,
            label: 'Raza',
            icon: Icons.category_outlined,
            validator: (v) => Validators.required(v, field: 'La raza'),
          ),
        ],
      ),
    );
  }
}
