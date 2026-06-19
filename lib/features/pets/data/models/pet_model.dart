import '../../domain/entities/pet_entity.dart';

class PetModel extends PetEntity {
  PetModel({
    required super.id,
    required super.name,
    required super.raza,
  });

  // El backend (Go) serializa el id de Pet como "Id" (mayúscula).
  // Toleramos ambas variantes por seguridad.
  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['Id'] ?? json['id'] ?? 0,
      name: json['name'] ?? '',
      raza: json['raza'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'raza': raza,
    };
  }
}
