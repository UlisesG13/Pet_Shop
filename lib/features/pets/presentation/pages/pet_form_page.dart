import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/pet_entity.dart';
import '../viewmodels/pets_viewmodel.dart';
import '../widgets/pet_form.dart';

class PetFormPage extends StatefulWidget {
  final PetEntity? pet;

  const PetFormPage({super.key, this.pet});

  @override
  State<PetFormPage> createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _raza;

  bool get _isEdit => widget.pet != null;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.pet?.name ?? '');
    _raza = TextEditingController(text: widget.pet?.raza ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _raza.dispose();
    super.dispose();
  }

  Future<void> _submit(PetsViewModel vm) async {
    if (!_formKey.currentState!.validate()) return;

    final ok = _isEdit
        ? await vm.updatePet(widget.pet!.id, _name.text.trim(), _raza.text.trim())
        : await vm.createPet(_name.text.trim(), _raza.text.trim());

    if (!mounted) return;
    if (ok) {
      AppUtils.showSnack(
        context,
        _isEdit ? 'Mascota actualizada' : 'Mascota creada',
      );
      Navigator.pop(context);
    } else {
      AppUtils.showSnack(context, vm.error ?? 'Ocurrió un error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PetsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Editar mascota' : 'Nueva mascota'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            PetForm(
              formKey: _formKey,
              nameController: _name,
              razaController: _raza,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: _isEdit ? 'Guardar cambios' : 'Crear',
              loading: vm.loading,
              onPressed: () => _submit(vm),
            ),
          ],
        ),
      ),
    );
  }
}
