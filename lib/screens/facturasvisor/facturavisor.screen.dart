import 'package:accesorios_industriales_sosa/models/factura.model.dart';
import 'package:accesorios_industriales_sosa/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../globals/widgets/widgets.dart';
import 'components/cardfactura.component.dart';

class FacturasVisor extends StatefulWidget {
  const FacturasVisor({
    Key? key,
  }) : super(key: key);
  @override
  State<FacturasVisor> createState() => _FacturasVisorState();
}

class _FacturasVisorState extends State<FacturasVisor> {
  String sumaCant(List<Factura> listproduccionElement) {
    num valor = 0;
    for (var e in listproduccionElement) {
      valor += e.precio;
    }
    return 'Lps ${formato.format(valor)}';
  }

  @override
  void initState() {
    initializeDateFormatting('es_MX', null);
    super.initState();
  }

  final formato = NumberFormat.decimalPattern('en-us');
  @override
  Widget build(BuildContext context) {
    final facturaProvider = Provider.of<FacturaProvider>(context);
    Size size = MediaQuery.of(context).size;
    final tema = Theme.of(context).colorScheme;
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          backgroundColor: tema.background,
          body: Column(
            children: [
              AppBar(
                backgroundColor: tema.background,
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      facturaProvider.resetProvider();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: tema.primary,
                    )),
                titleSpacing: 0,
                title:
                    TextSecundario(texto: 'Facturas', colorTexto: tema.primary),
              ),
              facturaProvider.listFacturaOrdenadaFecha.isNotEmpty
                  ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: facturaProvider.listFactura.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CardFactura(
                                      factura:
                                          facturaProvider.listFacturaOrdenadaFecha[index]);
                                }),
                            Container(
                              color: tema.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.03,
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: TextParrafo(
                                            colorTexto: tema.onPrimary,
                                            texto: 'Total General: ',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Row(
                                            // Agregado un Row para alinear correctamente los textos
                                            mainAxisAlignment: MainAxisAlignment
                                                .end, // Alinear a la derecha
                                            children: [
                                              Expanded(
                                                child: TextSecundario(
                                                  colorTexto: tema.onPrimary,
                                                  textAlign: TextAlign.right,
                                                  texto: sumaCant(facturaProvider
                                                      .listFactura),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ),
                  )
                  : NoDataWidget(
                      tema: tema,
                      size: size,
                    )
            ],
          ),
        ),
        if (facturaProvider.loading) CargandoWidget(size: size, conColor: true),
      ],
    ));
  }
}
