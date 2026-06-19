import '../entities/accessory_entity.dart';

abstract class AccessoriesRepository {
  Future<List<AccessoryEntity>> getAccessories();
  Future<void> createAccessory(String name, String description);
  Future<void> updateAccessory(int id, String name, String description);
  Future<void> deleteAccessory(int id);
}
