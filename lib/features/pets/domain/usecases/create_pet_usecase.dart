import '../repositories/pets_repository.dart';

class CreatePetUseCase {
  final PetsRepository repository;

  CreatePetUseCase(this.repository);

  Future<void> call(String name, String raza) {
    return repository.createPet(name, raza);
  }
}
