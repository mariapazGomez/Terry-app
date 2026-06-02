import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PestanaRegistros extends StatefulWidget {
  const PestanaRegistros({super.key});

  @override
  State<PestanaRegistros> createState() => _PestanaRegistrosState();
}

class _PestanaRegistrosState extends State<PestanaRegistros> {

  List registros = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerRegistros();
  }

  Future<void> obtenerRegistros() async {

    try {

      final response = await Supabase.instance.client
          .from('registros_financieros')
          .select();

      print(response);

      setState(() {
        registros = response;
        cargando = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text('Registros'),
      ),

      body: cargando
          ? const Center(
              child: CircularProgressIndicator(),
            )

          : registros.isEmpty

              ? const Center(
                  child: Text(
                    'No hay registros',
                    style: TextStyle(fontSize: 18),
                  ),
                )

              : ListView.builder(
                  itemCount: registros.length,

                  itemBuilder: (context, index) {

                    final item = registros[index];

                    return Card(
  elevation: 0,
  color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    side: BorderSide(
      color: Colors.grey.shade300,
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// TIPO + TOTAL
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              item['tipo_registro']
                  .toString()
                  .toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    item['tipo_registro'] == 'ingreso'
                        ? Colors.green
                        : Colors.red,
              ),
            ),

            Text(
              '${item['monto_total']} CLP',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// ESTADO
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            item['estado'] ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 16),

        /// FECHA
        Row(
          children: [

            const Icon(Icons.calendar_month, size: 18),

            const SizedBox(width: 8),

            Text(
              item['fecha'] ?? '',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// NETO
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [

            const Text(
              'Monto neto',
              style: TextStyle(fontSize: 16),
            ),

            Text(
              '${item['monto_neto']}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        /// IMPUESTO
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [

            const Text(
              'Impuesto',
              style: TextStyle(fontSize: 16),
            ),

            Text(
              '${item['monto_impuesto']}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// OBSERVACIONES
        if (item['observaciones'] != null)

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item['observaciones'],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
      ],
    ),
  ),
);
                  },
                ),
    );
  }
}
