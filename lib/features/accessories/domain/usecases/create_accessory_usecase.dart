import '../repositories/accessories_repository.dart';

class CreateAccessoryUseCase {
  final AccessoriesRepository repository;

  CreateAccessoryUseCase(this.repository);

  Future<void> call(String name, String description) {
    return repository.createAccessory(name, description);
  }
}
