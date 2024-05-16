import 'package:accesorios_industriales_sosa/controllers/clientes.controller.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../globals/widgets/widgets.dart';
import '../../models/models.dart';
import '../../providers/providers.dart';

class ActualizarClienteScreen extends StatefulWidget {
  final String nombreCliente;
  final bool estado;
  final int id;

  const ActualizarClienteScreen({
    Key? key,
    required this.nombreCliente,
    required this.estado,
    required this.id,
  }) : super(key: key);

  @override
  State<ActualizarClienteScreen> createState() =>
      _ActualizarClienteScreenState();
}

class _ActualizarClienteScreenState extends State<ActualizarClienteScreen>
    with WidgetsBindingObserver {
  late TextEditingController txtNombreCliente =
      TextEditingController(text: widget.nombreCliente);
  late bool activos;

  @override
  void initState() {
    super.initState();
    txtNombreCliente = TextEditingController(text: widget.nombreCliente);
    activos = widget.estado;
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return Stack(
      children: [
        Scaffold(
          appBar: customAppBar(
              tema: tema, titulo: "Actualizar Cliente", context: context),
          backgroundColor: tema.background,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: ListView(
              children: [
                const TextParrafo(texto: 'Nombre Cliente'),
                TextField(
                  controller: txtNombreCliente,
                  onChanged: (String value) {},
                  style: TextStyle(color: tema.onBackground),
                  decoration: InputDecoration(
                      labelStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      hintStyle:
                          GoogleFonts.sourceSansPro(color: tema.onBackground),
                      border: const OutlineInputBorder(),
                      hintText: "Ej: Mario Ponce"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextParrafo(texto: 'Estado'),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Switch(
                    value: activos,
                    onChanged: (value) {
                      setState(() {
                        activos = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonXXL(
                  funcion: () async {
                    int estado;

                    if (activos){
                      estado = 1;
                    }else{
                      estado = 0;
                    }
                    Cliente cliente = Cliente(nombre: txtNombreCliente.text, idCliente: widget.id, estado: estado);
                    ClientesLocalesController()
                        .actualizarCliente(cliente, context)
                        .then((value) => ClientesLocalesController().traerClientesLocales(context)).then((value) => Navigator.pop(context));
                  },
                  texto: 'Actualizar cliente',
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
    );
  }
}
