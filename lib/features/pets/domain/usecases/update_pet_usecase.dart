import '../repositories/pets_repository.dart';

class UpdatePetUseCase {
  final PetsRepository repository;

  UpdatePetUseCase(this.repository);

  Future<void> call(int id, String name, String raza) {
    return repository.updatePet(id, name, raza);
  }
}
