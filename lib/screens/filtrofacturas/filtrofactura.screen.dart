import 'package:accesorios_industriales_sosa/controllers/facturas.controller.dart';
import 'package:accesorios_industriales_sosa/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import '../../providers/providers.dart';
import 'components/buscarcliente.component.dart';

class FiltroFacuraScreen extends StatefulWidget {
  const FiltroFacuraScreen({Key? key}) : super(key: key);

  @override
  State<FiltroFacuraScreen> createState() => _FiltroFacuraScreenState();
}

class _FiltroFacuraScreenState extends State<FiltroFacuraScreen> {
  late TextEditingController txtFechaInicialController =
      TextEditingController();
  late TextEditingController txtFechaFinalController = TextEditingController();

  @override
  void initState() {
    initializeDateFormatting('es_MX', null);
    txtFechaInicialController.text =
        DateFormat.yMMMd('es-MX').format(DateTime.now());
    txtFechaFinalController.text =
        DateFormat.yMMMd('es-MX').format(DateTime.now());
    super.initState();
  }

  DateTime fechaInicio = DateTime.now();
  DateTime fechaFinal = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final clienteProvider = Provider.of<ClientesProvider>(context);
    final facturasProvider = Provider.of<FacturaProvider>(context);
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: tema.background,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: ListView(
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          clienteProvider.resetProvider();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: tema.primary,
                        )),
                    titleSpacing: 0,
                    title: TextSecundario(
                        texto: 'Facturas', colorTexto: tema.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Expanded(
                          flex: 3,
                          child: TextSecundario(
                              textAlign: TextAlign.left, texto: "Cliente:")),
                      Expanded(flex: 7, child: BuscadorClientesTodos()),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextParrafo(texto: 'Fecha desde'),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: tema.secondary),
                          readOnly: true,
                          controller: txtFechaInicialController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    bottom: 4.5,
                                    right: size.width * 0.02),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      color: tema.primary,
                                    ),
                                  ],
                                ),
                              )),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: fechaInicio,
                              firstDate: DateTime(2020, 3, 5),
                              lastDate: DateTime(2050, 3, 5),
                              locale: const Locale('es', 'ES'),
                            );
                            if (picked != null && picked != fechaInicio) {
                              setState(() {
                                fechaInicio = picked;
                                txtFechaInicialController.text =
                                    DateFormat.yMMMd('es-MX').format(picked);
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const TextParrafo(texto: 'Fecha hasta'),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: tema.secondary),
                          readOnly: true,
                          controller: txtFechaFinalController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.02,
                                    bottom: 4.5,
                                    right: size.width * 0.02),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.date_range_outlined,
                                      color: tema.primary,
                                    ),
                                  ],
                                ),
                              )),
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: fechaFinal,
                              firstDate: DateTime(2020, 3, 5),
                              lastDate: DateTime(2050, 3, 5),
                              locale: const Locale('es', 'ES'),
                            );
                            if (picked != null && picked != fechaFinal) {
                              setState(() {
                                fechaFinal = picked;
                                txtFechaFinalController.text =
                                    DateFormat.yMMMd('es-MX').format(picked);
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  ButtonXXL(
                    funcion: () async {
                      FacturasLocalesController()
                          .traerFacturasLocales(context, fechaInicio,
                              fechaFinal.add(const Duration(days: 1)))
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const FacturasVisor())));
                    },
                    texto: 'Continuar',
                    sinMargen: true,
                  ),
                ],
              ),
            ),
          ),
          if (clienteProvider.loading || facturasProvider.loading)
            CargandoWidget(size: size, conColor: true)
        ],
      ),
    );
  }
}
