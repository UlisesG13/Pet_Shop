import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/pet_entity.dart';
import '../viewmodels/pets_viewmodel.dart';
import '../widgets/pet_card.dart';
import '../widgets/pet_empty.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PetsViewModel>().loadPets();
    });
  }

  Future<void> _confirmDelete(PetsViewModel vm, PetEntity pet) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar mascota'),
        content: Text('¿Eliminar a "${pet.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final ok = await vm.deletePet(pet.id);
      if (mounted && !ok) {
        AppUtils.showSnack(context, vm.error ?? 'No se pudo eliminar');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PetsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Mascotas')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.petForm),
        icon: const Icon(Icons.add),
        label: const Text('Nueva'),
      ),
      body: RefreshIndicator(
        onRefresh: vm.loadPets,
        child: Builder(
          builder: (_) {
            if (vm.loading) return const LoadingWidget();
            if (vm.error != null) {
              return ListView(
                children: [
                  const SizedBox(height: 120),
                  Center(child: Text(vm.error!)),
                ],
              );
            }
            if (vm.pets.isEmpty) {
              return ListView(
                children: const [SizedBox(height: 160), PetEmpty()],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.pets.length,
              itemBuilder: (_, i) {
                final pet = vm.pets[i];
                return PetCard(
                  pet: pet,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.petDetail,
                    arguments: pet,
                  ),
                  onEdit: () => Navigator.pushNamed(
                    context,
                    AppRoutes.petForm,
                    arguments: pet,
                  ),
                  onDelete: () => _confirmDelete(vm, pet),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
