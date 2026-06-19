import '../repositories/accessories_repository.dart';

class DeleteAccessoryUseCase {
  final AccessoriesRepository repository;

  DeleteAccessoryUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteAccessory(id);
  }
}
