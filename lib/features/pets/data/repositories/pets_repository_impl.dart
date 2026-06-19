import '../../domain/entities/pet_entity.dart';
import '../../domain/repositories/pets_repository.dart';
import '../datasource/pets_remote_datasource.dart';
import '../models/pet_model.dart';

class PetsRepositoryImpl implements PetsRepository {
  final PetsRemoteDatasource datasource;

  PetsRepositoryImpl(this.datasource);

  @override
  Future<List<PetEntity>> getPets() async {
    final data = await datasource.getAll();
    return data
        .map((json) => PetModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> createPet(String name, String raza) {
    return datasource.create(name, raza);
  }

  @override
  Future<void> updatePet(int id, String name, String raza) {
    return datasource.update(id, name, raza);
  }

  @override
  Future<void> deletePet(int id) {
    return datasource.delete(id);
  }
}
