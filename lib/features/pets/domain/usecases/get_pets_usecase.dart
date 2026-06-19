import '../entities/pet_entity.dart';
import '../repositories/pets_repository.dart';

class GetPetsUseCase {
  final PetsRepository repository;

  GetPetsUseCase(this.repository);

  Future<List<PetEntity>> call() {
    return repository.getPets();
  }
}
