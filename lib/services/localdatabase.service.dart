// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataBaseService {
  static Database? _database;
  static final LocalDataBaseService db = LocalDataBaseService._();
  LocalDataBaseService._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDataBase();

    return _database!;
  }

  Future<Database> initDataBase() async {
    // Path donde almacenaremos la base de datos.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ais.db');
    // await deleteDatabase(path);

    // Creación de la base de datos.
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE Clientes(
          idCliente INTEGER PRIMARY KEY AUTOINCREMENT,
          nombreCliente TEXT,
          estado BIT
        )''');

        await db.execute('''CREATE TABLE Facturas(
          idFactura INTEGER PRIMARY KEY AUTOINCREMENT,
          idCliente INTEGER,
          numeroFactura TEXT,
          fecha DATE,
          precio DOUBLE,
          estado BIT,
          descripcion TEXT
        )''');

        await db.execute('''CREATE TABLE Usuario(
          IdUsuario INTEGER PRIMARY KEY AUTOINCREMENT,
          Usuario TEXT,
          Contraseña TEXT
        )''');

        // Insertar un primer usuario
        await db.rawInsert('''
        INSERT INTO Usuario (usuario, contraseña)
        VALUES (?, ?)
      ''', ['Usuario', '12345']);

        await db.rawInsert('''
  INSERT INTO Clientes (idCliente, nombreCliente, estado)
  VALUES (?, ?, ?)
''', [1, 'Cliente Final', 1]);
      },
    );
  }
}
