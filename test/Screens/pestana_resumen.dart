import 'package:flutter/material.dart';

class PestanaResumen extends StatefulWidget {
  const PestanaResumen({super.key});

  @override
  State<PestanaResumen> createState() => _PestanaResumenState();
}

class _PestanaResumenState extends State<PestanaResumen> {
  DateTime fechaActual = DateTime(2026, 3);

  void cambiarMes(int delta) {
    setState(() {
      fechaActual = DateTime(
        fechaActual.year,
        fechaActual.month + delta,
      );
    });
  }

  String obtenerMesAnio() {
    const meses = [
      "Enero","Febrero","Marzo","Abril","Mayo","Junio",
      "Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"
    ];
    return "${meses[fechaActual.month - 1]} de ${fechaActual.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [

            // 🔥 HEADER CON SELECTOR (NUEVO)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => cambiarMes(-1),
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    obtenerMesAnio().toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => cambiarMes(1),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),

            // 🔥 CONTENIDO ORIGINAL
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Buenas noches, Terry-admin",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 🔥 TEXTO DINÁMICO
                    Text(
                      "Resumen financiero de ${obtenerMesAnio().toLowerCase()}",
                      style: const TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 20),

                    // Cards indicadores
                    Row(
                      children: [
                        Expanded(child: _buildCard("Ingresos", "\$23.7M")),
                        const SizedBox(width: 10),
                        Expanded(child: _buildCard("Egresos", "\$15.4M")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildCard("Flujo Neto", "\$8.3M")),
                        const SizedBox(width: 10),
                        Expanded(child: _buildCard("Margen", "35.1%")),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Flujo de caja
                    const Text(
                      "Flujo de caja",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    _buildChartBox(),

                    const SizedBox(height: 20),

                    // Composición egresos
                    const Text(
                      "Composición de egresos",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    _buildChartBox(),

                    const SizedBox(height: 20),

                    // Cuentas por pagar
                    const Text(
                      "Cuentas por Pagar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    _buildChartBox(),

                    const SizedBox(height: 20),

                    // IVA
                    const Text(
                      "IVA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    _buildChartBox(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 reutilizable para todos los gráficos
  Widget _buildChartBox() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text("📊 Aquí irá el gráfico"),
      ),
    );
  }
}