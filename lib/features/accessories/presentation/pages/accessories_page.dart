import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/widgets/app_drawer.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/accessory_entity.dart';
import '../viewmodels/accessories_viewmodel.dart';
import '../widgets/accessory_card.dart';
import '../widgets/accessory_empty.dart';

class AccessoriesPage extends StatefulWidget {
  const AccessoriesPage({super.key});

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccessoriesViewModel>().loadAccessories();
    });
  }

  Future<void> _confirmDelete(
    AccessoriesViewModel vm,
    AccessoryEntity accessory,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar accesorio'),
        content: Text('¿Eliminar "${accessory.name}"?'),
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
      final ok = await vm.deleteAccessory(accessory.id);
      if (mounted && !ok) {
        AppUtils.showSnack(context, vm.error ?? 'No se pudo eliminar');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccessoriesViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Accesorios')),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.accessoryForm),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo'),
      ),
      body: RefreshIndicator(
        onRefresh: vm.loadAccessories,
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
            if (vm.accessories.isEmpty) {
              return ListView(
                children: const [SizedBox(height: 160), AccessoryEmpty()],
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.accessories.length,
              itemBuilder: (_, i) {
                final accessory = vm.accessories[i];
                return AccessoryCard(
                  accessory: accessory,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.accessoryDetail,
                    arguments: accessory,
                  ),
                  onEdit: () => Navigator.pushNamed(
                    context,
                    AppRoutes.accessoryForm,
                    arguments: accessory,
                  ),
                  onDelete: () => _confirmDelete(vm, accessory),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
