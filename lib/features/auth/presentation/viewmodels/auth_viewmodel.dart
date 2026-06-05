import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthViewModel({
    required this.loginUseCase,
    required this.registerUseCase,
  });

  bool loading = false;

  UserEntity? user;

  Future<void> login(
    String email,
    String password,
  ) async {
    loading = true;
    notifyListeners();

    user = await loginUseCase(
      email,
      password,
    );

    loading = false;
    notifyListeners();
  }

  Future<void> register(
    String email,
    String password,
    String name,
  ) async {
    loading = true;
    notifyListeners();

    await registerUseCase(
      email,
      password,
      name,
    );

    loading = false;
    notifyListeners();
  }
}