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
    final response =
        await datasource.login(email, password);

    final user =
        UserModel.fromJson(response['user']);

    return user;
  }

  @override
  Future<void> register(
    String email,
    String password,
    String name,
  ) async {
    await datasource.register(
      email,
      password,
      name,
    );
  }
}