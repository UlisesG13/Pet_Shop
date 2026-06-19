import 'package:flutter/material.dart';

import '../../domain/entities/accessory_entity.dart';
import '../../domain/usecases/create_accessory_usecase.dart';
import '../../domain/usecases/delete_accessory_usecase.dart';
import '../../domain/usecases/get_accessories_usecase.dart';
import '../../domain/usecases/update_accessory_usecase.dart';

class AccessoriesViewModel extends ChangeNotifier {
  final GetAccessoriesUseCase getAccessoriesUseCase;
  final CreateAccessoryUseCase createAccessoryUseCase;
  final UpdateAccessoryUseCase updateAccessoryUseCase;
  final DeleteAccessoryUseCase deleteAccessoryUseCase;

  AccessoriesViewModel({
    required this.getAccessoriesUseCase,
    required this.createAccessoryUseCase,
    required this.updateAccessoryUseCase,
    required this.deleteAccessoryUseCase,
  });

  bool loading = false;
  String? error;
  List<AccessoryEntity> accessories = [];

  Future<void> loadAccessories() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      accessories = await getAccessoriesUseCase();
    } catch (e) {
      error = _clean(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> createAccessory(String name, String description) {
    return _run(() => createAccessoryUseCase(name, description));
  }

  Future<bool> updateAccessory(int id, String name, String description) {
    return _run(() => updateAccessoryUseCase(id, name, description));
  }

  Future<bool> deleteAccessory(int id) {
    return _run(() => deleteAccessoryUseCase(id));
  }

  Future<bool> _run(Future<void> Function() action) async {
    try {
      await action();
      await loadAccessories();
      return true;
    } catch (e) {
      error = _clean(e);
      notifyListeners();
      return false;
    }
  }

  String _clean(Object e) => e.toString().replaceFirst('Exception: ', '');
}
