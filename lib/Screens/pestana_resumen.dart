import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:io';
import 'dart:convert';

class PestanaResumen extends StatefulWidget {
  const PestanaResumen({super.key});

  @override
  State<PestanaResumen> createState() => _PestanaResumenState();
}
Future<Map<String, dynamic>> cargarJson() async {
  final String response =
      await rootBundle.loadString('assets/flujo_caja.json');

  return json.decode(response);
}
Future<List<dynamic>> obtenerGraficos() async {

  final response = await Supabase.instance.client
      .from('dashboard_layout')
      .select();

  return response;
}

Future<List<dynamic>> obtenerWidgets() async {

  try {

    print("CONSULTANDO SUPABASE...");

    final response = await Supabase.instance.client
        .from('dashboard_layout')
        .select('widgets_json');

    print("RESPONSE:");
    print(response);

    // segunda fila
    final segundaFila = response[0];

    // jsonb
    final widgets = segundaFila['widgets_json'];
    //final widgets = snapshot.data!;

final grafico = widgets[2];

final title = grafico["title"];

final chart = grafico["chart"];

final echarts = chart["echarts_template"];

final xAxis = echarts["xAxis"]["data"];

final series = echarts["series"];

final primeraSerie = series[0];

final data = primeraSerie["data"];
print("title");
print(title);
print("xAxis");
print(xAxis);
print("data");
print(data);

    return widgets;

  } catch (e) {

    print("ERROR:");
    print(e);

    rethrow;
  }
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

                    _buildChartBoxSupa(),

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
Widget _buildAIChartBox() {
  return FutureBuilder<Map<String, dynamic>>(
    future: cargarJson(),
    builder: (context, snapshot) {

      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      final data = snapshot.data!;

      final List meses = data["meses"];
      final List valores = data["valores"];

      return Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: BarChart(
          BarChartData(

            borderData: FlBorderData(show: false),

            titlesData: FlTitlesData(

              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,

                  getTitlesWidget: (value, meta) {

                    return Text(
                      meses[value.toInt()],
                      style: const TextStyle(fontSize: 12),
                    );
                  },
                ),
              ),
            ),

            barGroups: List.generate(
              valores.length,
              (index) {

                return BarChartGroupData(
                  x: index,

                  barRods: [

                    BarChartRodData(
                      toY: valores[index].toDouble(),

                      width: 20,

                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
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

Widget _buildChartBoxSupa() {

  return FutureBuilder<List<dynamic>>(

    future: obtenerWidgets(),

    builder: (context, snapshot) {

      if (snapshot.connectionState == ConnectionState.waiting) {

        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError) {

        return Center(
          child: Text(snapshot.error.toString()),
        );
      }

      if (!snapshot.hasData) {

        return const Center(
          child: Text("No hay datos"),
        );
      }

      final widgets = snapshot.data!;

      // Primer gráfico
      final grafico = widgets[2];

      final title = grafico["title"];

      final chart = grafico["chart"];

      final echarts = chart["echarts_template"];

      final xAxis = echarts["xAxis"]["data"];

      final series = echarts["series"];

      final primeraSerie = series[0];

      final data = primeraSerie["data"];

      return Container(

        height: 320,

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: BarChart(

                BarChartData(

                  borderData: FlBorderData(show: false),

                  gridData: FlGridData(show: true),

                  titlesData: FlTitlesData(

                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),

                    bottomTitles: AxisTitles(

                      sideTitles: SideTitles(

                        showTitles: true,

                        getTitlesWidget: (value, meta) {

                          final index = value.toInt();

                          if (index >= xAxis.length) {
                            return const Text('');
                          }

                          return Padding(

                            padding: const EdgeInsets.only(top: 8),

                            child: Text(
                              xAxis[index]
                                  .toString()
                                  .substring(5), // MM-DD
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  barGroups: List.generate(

                    data.length,

                    (index) {

                      final valor =
                          data[index].toDouble();

                      return BarChartGroupData(

                        x: index,

                        barRods: [

                          BarChartRodData(

                            toY: valor,

                            width: 14,

                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}