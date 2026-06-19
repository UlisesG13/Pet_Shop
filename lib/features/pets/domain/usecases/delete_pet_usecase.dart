import '../repositories/pets_repository.dart';

class DeletePetUseCase {
  final PetsRepository repository;

  DeletePetUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deletePet(id);
  }
}
