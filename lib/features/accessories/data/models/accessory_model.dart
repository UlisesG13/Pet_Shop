import '../../domain/entities/accessory_entity.dart';

class AccessoryModel extends AccessoryEntity {
  AccessoryModel({
    required super.id,
    required super.name,
    required super.description,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}
