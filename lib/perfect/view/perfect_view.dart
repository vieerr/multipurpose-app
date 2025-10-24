import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controller/perfect_controller.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const NumberField({super.key, required this.controller, required this.hint});

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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class PerfectCard extends StatefulWidget {
  const PerfectCard({super.key});

  @override
  State<PerfectCard> createState() => _PerfectCardState();
}

class _PerfectCardState extends State<PerfectCard> {
  final _ctrlNumero = TextEditingController();
  final _controller = PerfectController();
  String _resultado = '';
  String _divisores = '';

  void _verificar() {
    final input = _ctrlNumero.text.trim();
    if (input.isEmpty) {
      return;
    }

    final number = int.tryParse(input);
    if (number == null || number <= 0) {
      return;
    }

    // Limit to reasonable numbers to prevent freeze
    if (number > 1000000) {
      setState(() {
        _resultado = 'Número muy grande (máximo 1.000.000)';
        _divisores = '';
      });
      return;
    }

    final perfect = _controller.checkNumber(number);
    setState(() {
      if (perfect != null) {
        if (perfect.isPerfect) {
          _resultado = '${perfect.number} es perfecto';
        } else {
          _resultado = '${perfect.number} no es perfecto';
        }
        _divisores =
            '${perfect.getDivisorsAsString()} = ${perfect.getDivisorsSum()}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Ingrese un número para verificar si es perfecto',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            NumberField(controller: _ctrlNumero, hint: 'Número'),
            const SizedBox(height: 20),
            PrimaryButton(text: 'Verificar', onPressed: _verificar),
            const SizedBox(height: 20),
            if (_resultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Column(
                  children: [
                    Text(
                      _resultado,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    if (_divisores.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        _divisores,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrlNumero.dispose();
    super.dispose();
  }
}

class PerfectPage extends StatelessWidget {
  const PerfectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Números Perfectos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: const Padding(padding: EdgeInsets.all(16), child: PerfectCard()),
      ),
    );
  }
}
