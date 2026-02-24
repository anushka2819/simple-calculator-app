import 'package:flutter/material.dart';
import 'calculator_logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark)),
      themeMode: ThemeMode.system,
      home: const CalcScreen(),
    );
  }
}

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  final calc = Calculator();

  void _onBtn(String btn) {
    setState(() {
      if (btn == 'C') calc.clear();
      else if (btn == '=') calc.calculate();
      else if (btn == '⌫') calc.backspace();
      else if (btn == '+/-') calc.toggleSign();
      else if (['+', '-', '×', '÷'].contains(btn)) calc.setOp(btn);
      else calc.addDigit(btn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (calc.expression.isNotEmpty)
                    Text(
                      calc.expression,
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  if (calc.showResult)
                    const SizedBox(height: 8),
                  if (calc.showResult)
                    Text(calc.display, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                  if (!calc.showResult && calc.expression.isEmpty)
                    Text(calc.display, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                'C', '⌫', '+/-', '÷',
                '7', '8', '9', '×',
                '4', '5', '6', '-',
                '1', '2', '3', '+',
                '0', '.', '00', '=',
              ].map((b) => _buildBtn(b)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(String label) {
    Color color = Colors.grey.shade700;
    if (label == 'C') color = Colors.red;
    if (label == '⌫') color = Colors.orange;
    if (['+', '-', '×', '÷', '='].contains(label)) color = label == '=' ? Colors.green : Colors.blue;

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _onBtn(label),
        child: Center(
          child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}
