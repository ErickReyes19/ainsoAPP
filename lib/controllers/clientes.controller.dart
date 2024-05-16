import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals/widgets/widgets.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../services/clientes.services.dart';

class ClientesLocalesController {
  final service = ClientesLocalesService();

  Future<bool> insertarCliente(Cliente cliente, context) async {
    final provider = Provider.of<ClientesProvider>(context, listen: false);
    try {
      provider.loading = true;
      service.insertarClienteLocal(cliente);
      provider.loading = false;
      sncackbarGlobal('Cliente agregado con éxito.', color: Colors.green);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> actualizarCliente(Cliente cliente, context) async {
    final provider = Provider.of<ClientesProvider>(context, listen: false);
    try {
      provider.loading = true;
      service.actualizarClienteLocal(cliente);
      provider.loading = false;
      sncackbarGlobal('Cliente actualizado con éxito.', color: Colors.green);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> traerClientesLocales(context) async {
    final provider = Provider.of<ClientesProvider>(context, listen: false);
    try {
      provider.loading = true;
      provider.listCliente = await service.traerClientesLocales();
      provider.loading = false;
      return true;
    } catch (e) {
      provider.listCliente = [];
      return false;
    }
  }

  Future<bool> traerClientesActivosLocales(context) async {
    final provider = Provider.of<ClientesProvider>(context, listen: false);
    try {
      provider.loading = true;
      provider.listCliente = await service.traerClientesActivosLocales();
      provider.loading = false;
      return true;
    } catch (e) {
      provider.listCliente = [];
      return false;
    }
  }
}
