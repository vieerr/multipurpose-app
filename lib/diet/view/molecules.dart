// molecules.dart
import 'package:flutter/material.dart';
import '../model/person_model.dart';
import '../model/weight_measurement_model.dart';
import 'atoms.dart';

class PersonCard extends StatelessWidget {
  final PersonModel person;
  final VoidCallback onTap;

  const PersonCard({super.key, required this.person, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final last = person.lastMeasurement;
    final diff = last?.difference;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        leading: Avatar(label: person.name, state: last?.state),
        title: Text(person.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Inicial: ${person.initialWeight.toStringAsFixed(2)} kg'),
            if (person.currentWeight != null) Text('Actual: ${person.currentWeight!.toStringAsFixed(2)} kg'),
          ],
        ),
        trailing: last != null
            ? StateBadge(difference: diff)
            : const Text('Sin mediciones', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class WeightFieldRow extends StatelessWidget {
  final TextEditingController controller;
  final int index;

  const WeightFieldRow({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Peso ${index + 1} (kg)', border: const OutlineInputBorder(), isDense: true),
        validator: (v) {
          if (v == null || v.trim().isEmpty) return null; // opcionales
          final n = double.tryParse(v);
          if (n == null || n <= 0) return 'Valor inválido';
          return null;
        },
      ),
    );
  }
}

class MeasurementItemCard extends StatelessWidget {
  final WeightMeasurementModel m;
  const MeasurementItemCard({super.key, required this.m});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text('Medición ${m.id} · ${m.averageWeight.toStringAsFixed(2)} kg'),
        subtitle: Text('Fecha: ${m.date.day}/${m.date.month}/${m.date.year}'),
        trailing: StateBadge(difference: m.difference),
      ),
    );
  }
}

class WeightField extends StatelessWidget {
  final TextEditingController controller;
  final int index;

  const WeightField({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Peso ${index + 1} (kg)',
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        validator: (v) {
          if (v == null || v.trim().isEmpty) return null;
          final n = double.tryParse(v);
          if (n == null || n <= 0) return 'Valor inválido';
          return null;
        },
      ),
    );
  }
}
class WeightGrid extends StatelessWidget {
  final List<TextEditingController> controllers;
  const WeightGrid({super.key, required this.controllers}) : assert(controllers.length == 10);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: List.generate(5, (i) => WeightField(controller: controllers[i], index: i)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: List.generate(5, (i) => WeightField(controller: controllers[i + 5], index: i + 5)),
          ),
        ),
      ],
    );
  }
}

class SpinosaurusImage extends StatelessWidget {
  final double? difference;

  const SpinosaurusImage({super.key, required this.difference});

  @override
  Widget build(BuildContext context) {
    String assetPath;

    if (difference == null || difference == 0) {
      assetPath = 'assets/images/spinosaurus_neutral.jpeg';
    } else if (difference! > 0) {
      assetPath = 'assets/images/spinosaurus_fat.jpeg';
    } else {
      assetPath = 'assets/images/spinosaurus_fit.jpeg';
    }
    return Center(
      child: Image.asset(
        assetPath,
        height: 120,
        fit: BoxFit.contain,
      ),
    );
  }
}
