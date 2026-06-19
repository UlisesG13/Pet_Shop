import 'package:flutter/material.dart';

import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class AccessoryForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController descriptionController;

  const AccessoryForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.descriptionController,
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
            controller: descriptionController,
            label: 'Descripción',
            icon: Icons.description_outlined,
            validator: (v) => Validators.required(v, field: 'La descripción'),
          ),
        ],
      ),
    );
  }
}
