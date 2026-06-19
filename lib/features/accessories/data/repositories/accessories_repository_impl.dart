import '../../domain/entities/accessory_entity.dart';
import '../../domain/repositories/accessories_repository.dart';
import '../datasource/accessories_remote_datasource.dart';
import '../models/accessory_model.dart';

class AccessoriesRepositoryImpl implements AccessoriesRepository {
  final AccessoriesRemoteDatasource datasource;

  AccessoriesRepositoryImpl(this.datasource);

  @override
  Future<List<AccessoryEntity>> getAccessories() async {
    final data = await datasource.getAll();
    return data
        .map((json) =>
            AccessoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> createAccessory(String name, String description) {
    return datasource.create(name, description);
  }

  @override
  Future<void> updateAccessory(int id, String name, String description) {
    return datasource.update(id, name, description);
  }

  @override
  Future<void> deleteAccessory(int id) {
    return datasource.delete(id);
  }
}
