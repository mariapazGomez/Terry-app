import 'package:flutter/material.dart';
import 'Screens/pestana_resumen.dart';
import 'Screens/pestana_registros.dart';

// 👇 pantallas mock por ahora
class RegistrosPage extends StatelessWidget {
  const RegistrosPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Registros"));
}

class IngresosPage extends StatelessWidget {
  const IngresosPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Ingresos"));
}

class GastosPage extends StatelessWidget {
  const GastosPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Gastos"));
}

class DocumentosPage extends StatelessWidget {
  const DocumentosPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Documentos"));
}

class ReportesPage extends StatelessWidget {
  const ReportesPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Reportes"));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PestanaResumen(),
    const PestanaRegistros(),
    const IngresosPage(),
    const GastosPage(),
    const DocumentosPage(),
    const ReportesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // 🔥 importante para +3 items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Resumen',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Registros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Ingresos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: 'Gastos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Documentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reportes',
          ),
        ],
      ),
    );
  }
}