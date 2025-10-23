import 'package:flutter/material.dart';
import '../controller/anios_controller.dart';
import 'package:flutter/services.dart';

class LabelText extends StatelessWidget {
  final String text;
  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.blue,
    ),
  );
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const NumberField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.blue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ResultText extends StatelessWidget {
  final String text;
  const ResultText(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.blue,
    ),
  );
}

class AnioInput extends StatelessWidget {
  final TextEditingController anio;

  const AnioInput({super.key, required this.anio});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: NumberField(controller: anio, hint: 'Año')),
      ],
    );
  }
}

class AnioCard extends StatefulWidget {
  const AnioCard({super.key});
  @override
  State<AnioCard> createState() => _AnioCardState();
}

class _AnioCardState extends State<AnioCard> {
  final _ctrlAnio = TextEditingController();
  final _controller = AnioController();
  String _resultado = '';

  void _verificar() {
    setState(() {
      _resultado = _controller.procesar(_ctrlAnio.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const LabelText('Ingrese un año para verificar si es bisiesto'),
            const SizedBox(height: 16),
            AnioInput(anio: _ctrlAnio),
            const SizedBox(height: 20),
            PrimaryButton(text: 'Verificar', onPressed: _verificar),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: ResultText(_resultado),
            ),
          ],
        ),
      ),
    );
  }
}

class AnioPage extends StatelessWidget {
  const AnioPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verificador de Años Bisiestos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: AnioCard(),
        ),
      ),
    );
  }
}