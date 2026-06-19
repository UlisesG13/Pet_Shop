import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

// Auth
import '../../features/auth/data/datasource/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';

// Pets
import '../../features/pets/data/datasource/pets_remote_datasource.dart';
import '../../features/pets/data/repositories/pets_repository_impl.dart';
import '../../features/pets/domain/usecases/create_pet_usecase.dart';
import '../../features/pets/domain/usecases/delete_pet_usecase.dart';
import '../../features/pets/domain/usecases/get_pets_usecase.dart';
import '../../features/pets/domain/usecases/update_pet_usecase.dart';
import '../../features/pets/presentation/viewmodels/pets_viewmodel.dart';

// Accessories
import '../../features/accessories/data/datasource/accessories_remote_datasource.dart';
import '../../features/accessories/data/repositories/accessories_repository_impl.dart';
import '../../features/accessories/domain/usecases/create_accessory_usecase.dart';
import '../../features/accessories/domain/usecases/delete_accessory_usecase.dart';
import '../../features/accessories/domain/usecases/get_accessories_usecase.dart';
import '../../features/accessories/domain/usecases/update_accessory_usecase.dart';
import '../../features/accessories/presentation/viewmodels/accessories_viewmodel.dart';

// Inyección de dependencias manual.
// Construye el grafo (datasource -> repository -> usecases -> viewmodel)
// y expone los providers para el MultiProvider raíz.
class InjectionContainer {
  late final http.Client _client;

  // ViewModels (singletons a nivel de app)
  late final AuthViewModel _authViewModel;
  late final PetsViewModel _petsViewModel;
  late final AccessoriesViewModel _accessoriesViewModel;

  InjectionContainer() {
    _client = http.Client();
    _initAuth();
    _initPets();
    _initAccessories();
  }

  void _initAuth() {
    final datasource = AuthRemoteDatasource(_client);
    final repository = AuthRepositoryImpl(datasource);
    _authViewModel = AuthViewModel(
      loginUseCase: LoginUseCase(repository),
      registerUseCase: RegisterUseCase(repository),
    );
  }

  void _initPets() {
    final datasource = PetsRemoteDatasource(_client);
    final repository = PetsRepositoryImpl(datasource);
    _petsViewModel = PetsViewModel(
      getPetsUseCase: GetPetsUseCase(repository),
      createPetUseCase: CreatePetUseCase(repository),
      updatePetUseCase: UpdatePetUseCase(repository),
      deletePetUseCase: DeletePetUseCase(repository),
    );
  }

  void _initAccessories() {
    final datasource = AccessoriesRemoteDatasource(_client);
    final repository = AccessoriesRepositoryImpl(datasource);
    _accessoriesViewModel = AccessoriesViewModel(
      getAccessoriesUseCase: GetAccessoriesUseCase(repository),
      createAccessoryUseCase: CreateAccessoryUseCase(repository),
      updateAccessoryUseCase: UpdateAccessoryUseCase(repository),
      deleteAccessoryUseCase: DeleteAccessoryUseCase(repository),
    );
  }

  // Envuelve el árbol con los providers de la app.
  Widget provide(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>.value(value: _authViewModel),
        ChangeNotifierProvider<PetsViewModel>.value(value: _petsViewModel),
        ChangeNotifierProvider<AccessoriesViewModel>.value(
          value: _accessoriesViewModel,
        ),
      ],
      child: child,
    );
  }
}
