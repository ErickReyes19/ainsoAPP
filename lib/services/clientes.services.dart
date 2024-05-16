// ignore_for_file: avoid_print

import 'package:accesorios_industriales_sosa/services/services.dart';

import '../models/models.dart';

class ClientesLocalesService {
  final database = LocalDataBaseService.db.database;

  insertarClienteLocal(Cliente cliente) async {
    final db = await database;
    final res = await db.insert('Clientes', cliente.toJson());

    return res;
  }

  Future<int> actualizarClienteLocal(Cliente cliente) async {
    final db = await database;
    return await db.update(
      'Clientes',
      cliente.toJson(),
      where: 'idCliente = ?',
      whereArgs: [cliente.idCliente],
    );
  }

  Future<List<Cliente>> traerClientesLocales() async {
    List<Cliente> listClientes = [];

    try {
      final db = await database;
      final res = await db.query('Clientes');

      if (res.isNotEmpty) {
        for (var e in res) {
          if (e.containsKey('idCliente') &&
              e.containsKey('nombreCliente') &&
              e.containsKey('estado')) {
            listClientes.add(Cliente.fromJson(e));
          } else {
            print(
                'La respuesta de la consulta no tiene todas las propiedades necesarias.');
          }
        }
      }
    } catch (e) {
      print('Error al traer clientes locales: $e');
    }

    return listClientes;
  }

  Future<List<Cliente>> traerClientesActivosLocales() async {
    List<Cliente> listClientes = [];

    try {
      final db = await database;
      final res =
          await db.query('Clientes', where: 'Estado = ?', whereArgs: [1]);

      if (res.isNotEmpty) {
        for (var e in res) {
          if (e.containsKey('idCliente') &&
              e.containsKey('nombreCliente') &&
              e.containsKey('estado')) {
            listClientes.add(Cliente.fromJson(e));
          } else {
            print(
                'La respuesta de la consulta no tiene todas las propiedades necesarias.');
          }
        }
      }
    } catch (e) {
      print('Error al traer clientes locales: $e');
    }

    return listClientes;
  }
}
