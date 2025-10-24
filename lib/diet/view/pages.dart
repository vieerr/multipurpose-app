// pages.dart
import 'package:flutter/material.dart';
import '../controller/person_controller.dart';
import '../model/person_model.dart';
import 'organisms.dart';

class DietPage extends StatefulWidget {
  final PersonController controller;
  const DietPage({super.key, required this.controller});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  void _refresh() => setState(() {});

  void _openPerson(PersonModel p) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => Scaffold(
        appBar: AppBar(
            title: Text(p.name),
            backgroundColor: Colors.blue,
        ),
        body: PersonDetailOrganism(controller: widget.controller, person: p),
      )),
    ).then((_) => _refresh());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          'DINO-PESO 🦖',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(1.5, 1.5),
                blurRadius: 4,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            PersonFormOrganism(controller: widget.controller, onCreated: (p) => _openPerson(p)),
            const SizedBox(height: 12),
            const Align(alignment: Alignment.centerLeft, child: Text('Personas', style: TextStyle(fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            PersonListOrganism(controller: widget.controller, onOpenPerson: (p) => _openPerson(p)),
          ],
        ),
      ),
    );
  }
}
