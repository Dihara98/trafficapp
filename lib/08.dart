void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LicenseCategoriesScreen(),
    );
  }
}

class LicenseCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800],
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Table(
              border: TableBorder.all(color: Colors.grey), // Table border
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Categories of vehicles',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Date of Issue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Date of Expiry',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                for (var category in vehicleCategories)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            category['category'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            category['issueDate'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            category['expiryDate'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Status:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              'Active',
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
            Text(
              'Expired',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> vehicleCategories = [
  {'category': 'A1', 'issueDate': '...........', 'expiryDate':'...........'},
  {'category': 'A', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'B1', 'issueDate': '...........', 'expiryDate':'...........'},
  {'category': 'B', 'issueDate':'...........', 'expiryDate': '...........'},
  {'category': 'B2', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'C1', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'C', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'CE', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'D1', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'D', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'DE', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'G1', 'issueDate':'...........', 'expiryDate': '...........'},
  {'category': 'G', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'J', 'issueDate': '...........', 'expiryDate': '...........'},
  {'category': 'H', 'issueDate': '...........', 'expiryDate': '...........'},
]