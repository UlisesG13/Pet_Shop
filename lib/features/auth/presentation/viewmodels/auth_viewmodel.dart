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
  String? error;
  UserEntity? user;

  bool get isLoggedIn => user != null;

  Future<bool> login(
    String email,
    String password,
  ) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      user = await loginUseCase(email, password);
      return true;
    } catch (e) {
      error = _clean(e);
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> register(
    String email,
    String password,
    String name,
  ) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      await registerUseCase(email, password, name);
      return true;
    } catch (e) {
      error = _clean(e);
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void logout() {
    user = null;
    error = null;
    notifyListeners();
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}
