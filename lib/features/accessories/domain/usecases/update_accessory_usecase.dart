import '../repositories/accessories_repository.dart';

class UpdateAccessoryUseCase {
  final AccessoriesRepository repository;

  UpdateAccessoryUseCase(this.repository);

  Future<void> call(int id, String name, String description) {
    return repository.updateAccessory(id, name, description);
  }
}
