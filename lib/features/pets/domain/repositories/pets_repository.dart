import '../entities/pet_entity.dart';

abstract class PetsRepository {
  Future<List<PetEntity>> getPets();
  Future<void> createPet(String name, String raza);
  Future<void> updatePet(int id, String name, String raza);
  Future<void> deletePet(int id);
}
