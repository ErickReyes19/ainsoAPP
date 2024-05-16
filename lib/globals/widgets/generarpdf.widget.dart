// ignore_for_file: unused_local_variable



import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

import '../../models/factura.model.dart';

Future<void> generateAndSharePdf(
  
    List<Factura> facturas, String nombreCliente, String total) async {
      final formato = NumberFormat.decimalPattern('en_us');
  final pdf = pw.Document();
  // Agregar una imagen pequeña
  final ByteData data = await rootBundle.load(
      'assets/images/iaslogo.png'); // Reemplaza 'assets/logo.png' con la ruta de tu imagen
  final Uint8List uint8List = data.buffer.asUint8List();
  final image = pw.MemoryImage(uint8List);

  // Agrupar los elementos en una sola página
  pdf.addPage(pw.MultiPage(
    build: (context) {
      return [
        
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
          pw.Text('Accesorios Industiales Sosa',
              style:
                  pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.Image(image, width: 100)
        ]),
        pw.SizedBox(height: 15),
        
        pw.Row(children: [
          pw.Text('Cliente: ', style: const pw.TextStyle(fontSize: 16)),
          pw.Text(nombreCliente,
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold))
        ]),
        pw.SizedBox(height: 10),
        pw.Table.fromTextArray(
          
          headerAlignment: pw.Alignment.center,
          headers: ['Fecha', 'N° Factura', 'Descripción', 'V. Factura'],
          data: facturas.map((factura) {
            return [
              DateFormat('d MMMM y', 'es-MX').format(factura.fecha),
              factura.numeroFactura,
              factura.descripcion,
              'LPS ${factura.precio}',
            ];
          }).toList(),
          border: null,
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          cellAlignment: pw.Alignment.center,
        ),
        pw.SizedBox(height: 10),
        pw.Divider(),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment
                .spaceBetween, // Alinea el texto del total a la derecha
            children: [
              pw.Text('Total:', style: const pw.TextStyle(fontSize: 16)),
              pw.Text(total,
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold))
            ])
      ];
    },
  ));

  // Obtener el directorio temporal del dispositivo
  final tempDir = await getTemporaryDirectory();

  // Crear un archivo en el directorio temporal
  final pdfFile = File('${tempDir.path}/facturas_$nombreCliente.pdf');

  // Guardar el PDF en el archivo
  await pdfFile.writeAsBytes(await pdf.save());

  // Compartir el PDF utilizando la biblioteca open_file
  await OpenFile.open(pdfFile.path);
}
