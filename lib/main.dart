// ignore_for_file: empty_catches, avoid_print, depend_on_referenced_packages

import 'package:accesorios_industriales_sosa/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constans.dart';
import 'providers/providers.dart';
import 'services/localdatabase.service.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Inicializar Flutter

  final databaseService = LocalDataBaseService.db;

  try {
    final database = await databaseService.initDataBase();
    final tables = await database
        .rawQuery("SELECT name FROM sqlite_master WHERE type='table';");

    // Mostrar el nombre de las tablas en la consola
    for (final table in tables) {
      print('Tabla creada: ${table['name']}');
    }

    runApp(const MyApp());
  } catch (e) {}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ClientesProvider()),
        ChangeNotifierProvider(create: (context) => FacturaProvider()),
      ],
      child: MaterialApp(
          localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
          supportedLocales: const [ Locale('es', 'ES')],
          locale: const Locale('es', 'ES'),
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackbarKey,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 255, 255, 255)),
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Color(0xffF2F2F2)),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style:
                    ElevatedButton.styleFrom(backgroundColor: const Color(0xff312E5C))),
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color.fromARGB(255, 5, 26, 160),
                onPrimary: Color.fromARGB(255, 255, 255, 255),
                secondary: Color.fromARGB(255, 0, 0, 0),
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                background: Color.fromARGB(255, 243, 243, 243),
                onBackground: Color.fromARGB(255, 0, 0, 0),
                surface: Color.fromARGB(255, 255, 255, 255),
                onSurface: Color.fromRGBO(255, 13, 0, 44),
                onSurfaceVariant: Color.fromARGB(255, 102, 102, 102)),
          ),
          title: 'Material App',
          home: const HomeScreen()),
    );
  }
}
