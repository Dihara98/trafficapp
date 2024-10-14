import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vehicle License Status'),
        ),
        body: VehicleTable(),
      ),
    );
  }
}

class VehicleTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Categories of vehicles')),
            DataColumn(label: Text('Date of Issue')),
            DataColumn(label: Text('Date of Expiry')),
          ],
          rows: const <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('A1')),
                DataCell(Text('21.03.2017')),
                DataCell(Text('21.03.2025')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('A')),
                DataCell(Text('21.03.2017')),
                DataCell(Text('21.03.2025')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('B1')),
                DataCell(Text('21.03.2017')),
                DataCell(Text('21.03.2025')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('B')),
                DataCell(Text('21.03.2017')),
                DataCell(Text('21.03.2025')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('B2')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('C1')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('C')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('CE')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('D1')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('D')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('DE')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('GI')),
                DataCell(Text('21.03.2017')),
                DataCell(Text('21.03.2025')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('G')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('J')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('H')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
