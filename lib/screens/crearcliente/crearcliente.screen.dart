import 'package:accesorios_industriales_sosa/controllers/clientes.controller.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

class CrearClienteScreen extends StatefulWidget {
  const CrearClienteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CrearClienteScreen> createState() => _CrearClienteScreenState();
}

class _CrearClienteScreenState extends State<CrearClienteScreen>
    with WidgetsBindingObserver {
  late TextEditingController txtNombreCliente = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: customAppBar(
                tema: tema, titulo: "Crear cliente", context: context),
            backgroundColor: tema.background,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: ListView(
                children: [
                  TextParrafo(
                      fontWeight: FontWeight.bold,
                      colorTexto: tema.primary,
                      texto: 'Nombre Cliente'),
                  TextField(
                    controller: txtNombreCliente,
                    onChanged: (String value) {},
                    style: TextStyle(color: tema.primary),
                    decoration: InputDecoration(
                        labelStyle:
                            GoogleFonts.sourceSansPro(color: tema.onBackground),
                        hintStyle:
                            GoogleFonts.sourceSansPro(color: tema.primary),
                        border: const OutlineInputBorder(),
                        hintText: "Ej: Mario Ponce"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonXXL(
                    funcion: () async {
                      if(txtNombreCliente.text.isEmpty){
                        alertError(context, mensaje: "Debe de colocar un nombre");
                        return;
                      }
                      Cliente cliente =
                          Cliente(nombre: txtNombreCliente.text, estado: 1);
                      ClientesLocalesController()
                          .insertarCliente(cliente, context).then((value) => 
                            clientesProvider.resetProvider()
                          )
                          .then((value) => ClientesLocalesController()
                              .traerClientesLocales(context))
                          .then((value) => Navigator.pop(context));
                    },
                    texto: 'Crear cliente',
                    sinMargen: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          if (clientesProvider.loading)
            CargandoWidget(size: size, conColor: true)
        ],
      ),
    );
  }
}
