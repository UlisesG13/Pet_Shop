import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> login(
    String email,
    String password,
  ) async {
    final response = await datasource.login(email, password);

    if (response['user'] == null) {
      throw Exception(response['error'] ?? 'Credenciales incorrectas');
    }

    return UserModel.fromJson(response['user']);
  }

  @override
  Future<void> register(
    String email,
    String password,
    String name,
  ) async {
    final response = await datasource.register(email, password, name);

    if (response['error'] != null) {
      throw Exception(response['error']);
    }
  }
}
