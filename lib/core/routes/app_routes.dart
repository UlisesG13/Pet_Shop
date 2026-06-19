import 'package:flutter/material.dart';

import '../../features/accessories/domain/entities/accessory_entity.dart';
import '../../features/accessories/presentation/pages/accessories_page.dart';
import '../../features/accessories/presentation/pages/accessory_detail_page.dart';
import '../../features/accessories/presentation/pages/accessory_form_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/pets/domain/entities/pet_entity.dart';
import '../../features/pets/presentation/pages/pet_detail_page.dart';
import '../../features/pets/presentation/pages/pet_form_page.dart';
import '../../features/pets/presentation/pages/pets_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';

  static const String pets = '/pets';
  static const String petDetail = '/pets/detail';
  static const String petForm = '/pets/form';

  static const String accessories = '/accessories';
  static const String accessoryDetail = '/accessories/detail';
  static const String accessoryForm = '/accessories/form';

  static const String initial = login;

  // Navigation 1.0: rutas centralizadas con paso de argumentos.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _page(const LoginPage());
      case register:
        return _page(const RegisterPage());

      case pets:
        return _page(const PetsPage());
      case petDetail:
        return _page(PetDetailPage(pet: settings.arguments as PetEntity));
      case petForm:
        return _page(PetFormPage(pet: settings.arguments as PetEntity?));

      case accessories:
        return _page(const AccessoriesPage());
      case accessoryDetail:
        return _page(
          AccessoryDetailPage(
            accessory: settings.arguments as AccessoryEntity,
          ),
        );
      case accessoryForm:
        return _page(
          AccessoryFormPage(
            accessory: settings.arguments as AccessoryEntity?,
          ),
        );

      default:
        return _page(
          const Scaffold(
            body: Center(child: Text('Ruta no encontrada')),
          ),
        );
    }
  }

  static MaterialPageRoute _page(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
