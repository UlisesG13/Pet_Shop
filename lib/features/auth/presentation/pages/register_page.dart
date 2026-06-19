import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_header.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthViewModel vm) async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await vm.register(
      _email.text.trim(),
      _password.text,
      _name.text.trim(),
    );
    if (!mounted) return;

    if (ok) {
      AppUtils.showSnack(context, 'Cuenta creada, inicia sesión');
      Navigator.pop(context);
    } else {
      AppUtils.showSnack(context, vm.error ?? 'Error al registrar');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingL),
            child: Column(
              children: [
                const AuthHeader(
                  title: 'Crear cuenta',
                  subtitle: 'Regístrate para empezar',
                ),
                const SizedBox(height: 32),
                AuthForm(
                  formKey: _formKey,
                  emailController: _email,
                  passwordController: _password,
                  nameController: _name,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Registrarme',
                  loading: vm.loading,
                  onPressed: () => _submit(vm),
                ),
                const SizedBox(height: 8),
                AuthFooter(
                  question: '¿Ya tienes cuenta?',
                  action: 'Inicia sesión',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
