import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_form.dart';
import '../widgets/auth_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit(AuthViewModel vm) async {
    if (!_formKey.currentState!.validate()) return;

    final ok = await vm.login(_email.text.trim(), _password.text);
    if (!mounted) return;

    if (ok) {
      Navigator.pushReplacementNamed(context, AppRoutes.pets);
    } else {
      AppUtils.showSnack(context, vm.error ?? 'Error al iniciar sesión');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingL),
            child: Column(
              children: [
                const AuthHeader(
                  title: 'Bienvenido',
                  subtitle: 'Inicia sesión para continuar',
                ),
                const SizedBox(height: 32),
                AuthForm(
                  formKey: _formKey,
                  emailController: _email,
                  passwordController: _password,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  label: 'Entrar',
                  loading: vm.loading,
                  onPressed: () => _submit(vm),
                ),
                const SizedBox(height: 8),
                AuthFooter(
                  question: '¿No tienes cuenta?',
                  action: 'Regístrate',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.register),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
