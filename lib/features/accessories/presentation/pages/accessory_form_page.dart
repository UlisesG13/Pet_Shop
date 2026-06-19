import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/accessory_entity.dart';
import '../viewmodels/accessories_viewmodel.dart';
import '../widgets/accessory_form.dart';

class AccessoryFormPage extends StatefulWidget {
  final AccessoryEntity? accessory;

  const AccessoryFormPage({super.key, this.accessory});

  @override
  State<AccessoryFormPage> createState() => _AccessoryFormPageState();
}

class _AccessoryFormPageState extends State<AccessoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;

  bool get _isEdit => widget.accessory != null;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.accessory?.name ?? '');
    _description =
        TextEditingController(text: widget.accessory?.description ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit(AccessoriesViewModel vm) async {
    if (!_formKey.currentState!.validate()) return;

    final ok = _isEdit
        ? await vm.updateAccessory(
            widget.accessory!.id, _name.text.trim(), _description.text.trim())
        : await vm.createAccessory(_name.text.trim(), _description.text.trim());

    if (!mounted) return;
    if (ok) {
      AppUtils.showSnack(
        context,
        _isEdit ? 'Accesorio actualizado' : 'Accesorio creado',
      );
      Navigator.pop(context);
    } else {
      AppUtils.showSnack(context, vm.error ?? 'Ocurrió un error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccessoriesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Editar accesorio' : 'Nuevo accesorio'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            AccessoryForm(
              formKey: _formKey,
              nameController: _name,
              descriptionController: _description,
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
