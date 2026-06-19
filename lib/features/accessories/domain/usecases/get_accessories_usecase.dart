import '../entities/accessory_entity.dart';
import '../repositories/accessories_repository.dart';

class GetAccessoriesUseCase {
  final AccessoriesRepository repository;

  GetAccessoriesUseCase(this.repository);

  Future<List<AccessoryEntity>> call() {
    return repository.getAccessories();
  }
}
