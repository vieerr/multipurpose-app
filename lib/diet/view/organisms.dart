import 'package:flutter/material.dart';
import '../controller/person_controller.dart';
import '../model/person_model.dart';
import 'atoms.dart';
import 'molecules.dart';


class PersonFormOrganism extends StatefulWidget {
  final PersonController controller;
  final void Function(PersonModel) onCreated;
  const PersonFormOrganism({super.key, required this.controller, required this.onCreated});

  @override
  State<PersonFormOrganism> createState() => _PersonFormOrganismState();
}

class _PersonFormOrganismState extends State<PersonFormOrganism> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _initialCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _initialCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final name = _nameCtrl.text.trim();
    final weight = double.parse(_initialCtrl.text.trim());
    final person = widget.controller.addPerson(name, weight);
    _nameCtrl.clear();
    _initialCtrl.clear();
    widget.onCreated(person);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const LabelText('Registrar Persona'),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Nombre',
                  controller: _nameCtrl,
                  validator: (v) =>
                  (v == null || v
                      .trim()
                      .isEmpty) ? 'Ingrese nombre' : null,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  label: 'Peso inicial (kg)',
                  controller: _initialCtrl,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v
                        .trim()
                        .isEmpty) return 'Ingrese peso';
                    final n = double.tryParse(v.trim());
                    if (n == null || n <= 0) return 'Peso inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                PrimaryButton(text: 'Guardar y continuar', onPressed: _save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersonListOrganism extends StatelessWidget {
  final PersonController controller;
  final void Function(PersonModel) onOpenPerson;
  const PersonListOrganism({super.key, required this.controller, required this.onOpenPerson});

  @override
  Widget build(BuildContext context) {
    final persons = controller.persons;
    if (persons.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No hay personas registradas', style: TextStyle(color: Colors.grey)),
      );
    }

    return Column(
      children: persons.map((p) => PersonCard(person: p, onTap: () => onOpenPerson(p))).toList(),
    );
  }
}


class MeasurementFormOrganism extends StatefulWidget {
  final PersonController controller;
  final PersonModel person;
  final VoidCallback onSaved;

  const MeasurementFormOrganism({
    super.key,
    required this.controller,
    required this.person,
    required this.onSaved,
  });

  @override
  State<MeasurementFormOrganism> createState() => _MeasurementFormOrganismState();
}

class _MeasurementFormOrganismState extends State<MeasurementFormOrganism> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _weightCtrls = List.generate(10, (_) => TextEditingController());

  @override
  void dispose() {
    for (var c in _weightCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final vals = _weightCtrls
        .map((c) => double.tryParse(c.text.trim()) ?? 0.0)
        .where((v) => v > 0)
        .toList();

    if (vals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese al menos un peso válido')),
      );
      return;
    }

    widget.controller.addMeasurement(widget.person.id, vals);

    for (var c in _weightCtrls) {
      c.clear();
    }
    widget.onSaved();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medición guardada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.person;
    final comparisonLabel = p.isFirstMeasurement ? 'Comparación: Peso inicial' : 'Comparación: Última medición';
    final comparisonValue = p.isFirstMeasurement ? p.initialWeight : p.lastMeasurement!.averageWeight;
    final difference = p.lastMeasurement?.difference;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const Expanded(child: LabelText('Agregar medición (10 pesajes)')),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(comparisonLabel,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis),
                    Text('${comparisonValue.toStringAsFixed(2)} kg',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            WeightGrid(controllers: _weightCtrls),
            const SizedBox(height: 12),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: SpinosaurusImage(
                key: ValueKey(difference),
                difference: difference,
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(text: 'Guardar medición', onPressed: _save),
          ]),
        ),
      ),
    );
  }
}

class PersonDetailOrganism extends StatefulWidget {
  final PersonController controller;
  final PersonModel person;
  const PersonDetailOrganism({super.key, required this.controller, required this.person});

  @override
  State<PersonDetailOrganism> createState() => _PersonDetailOrganismState();
}

class _PersonDetailOrganismState extends State<PersonDetailOrganism> {
  void _onSaved() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final p = widget.person;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          MeasurementFormOrganism(controller: widget.controller, person: p, onSaved: _onSaved),
          const SizedBox(height: 12),
          const LabelText('Historial de Mediciones'),
          const SizedBox(height: 8),
          if (p.measurements.isEmpty)
            const Text('No hay mediciones', style: TextStyle(color: Colors.grey))
          else
            for (var m in p.measurements) MeasurementItemCard(m: m),
        ],
      ),
    );
  }
}