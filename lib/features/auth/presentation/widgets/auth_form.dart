import 'package:flutter/material.dart';

import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/custom_text_field.dart';

class AuthForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;

  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          if (nameController != null) ...[
            CustomTextField(
              controller: nameController!,
              label: 'Nombre',
              icon: Icons.person_outline,
              validator: (v) => Validators.required(v, field: 'El nombre'),
            ),
            const SizedBox(height: 14),
          ],
          CustomTextField(
            controller: emailController,
            label: 'Correo',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          const SizedBox(height: 14),
          CustomTextField(
            controller: passwordController,
            label: 'Contraseña',
            icon: Icons.lock_outline,
            obscure: true,
            validator: Validators.password,
          ),
        ],
      ),
    );
  }
}
