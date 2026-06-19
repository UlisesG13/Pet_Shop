import 'package:flutter/material.dart';

import '../../domain/entities/pet_entity.dart';
import '../../domain/usecases/create_pet_usecase.dart';
import '../../domain/usecases/delete_pet_usecase.dart';
import '../../domain/usecases/get_pets_usecase.dart';
import '../../domain/usecases/update_pet_usecase.dart';

class PetsViewModel extends ChangeNotifier {
  final GetPetsUseCase getPetsUseCase;
  final CreatePetUseCase createPetUseCase;
  final UpdatePetUseCase updatePetUseCase;
  final DeletePetUseCase deletePetUseCase;

  PetsViewModel({
    required this.getPetsUseCase,
    required this.createPetUseCase,
    required this.updatePetUseCase,
    required this.deletePetUseCase,
  });

  bool loading = false;
  String? error;
  List<PetEntity> pets = [];

  Future<void> loadPets() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      pets = await getPetsUseCase();
    } catch (e) {
      error = _clean(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> createPet(String name, String raza) async {
    return _run(() => createPetUseCase(name, raza));
  }

  Future<bool> updatePet(int id, String name, String raza) async {
    return _run(() => updatePetUseCase(id, name, raza));
  }

  Future<bool> deletePet(int id) async {
    return _run(() => deletePetUseCase(id));
  }

  Future<bool> _run(Future<void> Function() action) async {
    try {
      await action();
      await loadPets();
      return true;
    } catch (e) {
      error = _clean(e);
      notifyListeners();
      return false;
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}
