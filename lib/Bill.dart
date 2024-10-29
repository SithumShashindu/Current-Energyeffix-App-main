import 'package:energyeffix_app/Components/MyNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Components/CustomAppBar.dart';
import 'Components/CustomDrawer.dart';

class Bill extends StatelessWidget {
  final String month;
  final int unitsUsed;
  final double usageAmount;
  final double totalAmount;

  Bill({
    required this.month,
    required this.unitsUsed,
    required this.usageAmount,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white), // Setting default text color to white
        ),
      ),
      home: BillPage(),
    );
  }
}

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  double kWh = 0;
  double totalAmount = 0;
  int fixedCharges = 0;
  double usageAmount = 0;
  double total1 = 0;

  Future<void> fetchKwhAndCalculate() async {
    final kWhResponse = await http
        .get(Uri.parse('http://192.168.128.198/login_sdgp/bill_connected.php'));
    if (kWhResponse.statusCode == 200) {
      final units = double.parse(kWhResponse.body);
      setState(() {
        kWh = units;
      });
      double total = 0;
      if (units >= 0 && units <= 30) {
        total = units * 8 + 150;
      } else if (units > 30 && units <= 60) {
        total = 240 + (units - 30) * 20 + 300;
      } else if (units > 60 && units <= 90) {
        total = 840 + (units - 60) * 30 + 400;
      } else if (units > 90 && units <= 120) {
        total = 1740 + (units - 90) * 50 + 1000;
      } else if (units > 120 && units <= 180) {
        total = 3240 + (units - 120) * 50 + 1500;
      } else {
        total = 6240 + (units - 180) * 75 + 2000;
      }
      setState(() {
        if (units >= 0 && units <= 30) {
          fixedCharges = 150;
          usageAmount = units * 8;
          total1 = usageAmount * 0.18; // Adding 18% tax
          totalAmount = total1 + usageAmount + fixedCharges;
        } else if (units > 30 && units <= 60) {
          fixedCharges = 300;
          usageAmount = units * 20;
          total1 = usageAmount * 0.18; // Adding 18% tax
          totalAmount = total1 + usageAmount + fixedCharges;
        } else if (units > 60 && units <= 90) {
          fixedCharges = 400;
          usageAmount = units * 30;
          total1 = usageAmount * 0.18; // Adding 18% tax
          totalAmount = total1 + usageAmount + fixedCharges;
        } else if (units > 90 && units <= 120) {
          fixedCharges = 1000;
          usageAmount = units * 50;
          total1 = usageAmount * 0.18; // Adding 18% tax
          totalAmount = total1 + usageAmount + fixedCharges;
        } else if (units > 120 && units <= 180) {
          fixedCharges = 1500;
          usageAmount = units * 50;
          total1 = usageAmount * 0.18; // Adding 18% tax
          totalAmount = total1 + usageAmount + fixedCharges;
        } else {
          fixedCharges = 2000;
          usageAmount = units * 75;
          total1 = usageAmount * 0.18; // Adding 18% tax
          totalAmount = total1 + usageAmount + fixedCharges;
        }
      });
    } else {
      throw Exception('Failed to load kWh value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: CustomAppBar(
              appBar: AppBar(
                toolbarHeight: 120,
              ),
              title: "Bill"),
          drawer: CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Month of March Bill',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Table(
                  border: TableBorder.all(
                      width: 2,
                      color: Colors.white), // Set border color to white
                  columnWidths: {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                    5: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Center(
                              child: Text('1-30',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('31-60',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('61-90',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('91-120',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('121-180',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('180<',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white)))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Center(
                              child: Text('LKR 8',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('LKR 20',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('LKR 30',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('LKR 50',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('LKR 50',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)))),
                      TableCell(
                          child: Center(
                              child: Text('LKR 75',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)))),
                    ]),
                  ],
                ),
                SizedBox(height: 50),
                Table(
                  border: TableBorder.all(
                      width: 2,
                      color: Colors.white), // Set border color to white
                  columnWidths: {0: FlexColumnWidth(), 1: FlexColumnWidth()},
                  children: [
                    TableRow(children: [
                      TableCell(
                          child: Text('Total Units Used',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white))),
                      TableCell(
                          child: Text('$kWh',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Text('Usage Amount',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white))),
                      TableCell(
                          child: Text('LKR $usageAmount',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Text('Fixed Charges',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white))),
                      TableCell(
                          child: Text('$fixedCharges',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Text('Tax-VAT',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white))),
                      TableCell(
                          child: Text('18%',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))),
                    ]),
                    TableRow(children: [
                      TableCell(
                          child: Text('Total Amount',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.white))),
                      TableCell(
                          child: Text('LKR $totalAmount',
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))),
                    ]),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: fetchKwhAndCalculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calculate, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text('Calculate Bill',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showBillPaymentOverlay(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.payment, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text('Pay Bill', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBillPaymentOverlay(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.blue,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _navigateToWebsite('https://www.leco.lk/index_e.php');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('LECO', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _navigateToWebsite('https://www.ceb.lk/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('CEB', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToWebsite(String url) {
    // Navigate to the provided URL
    // Example: Launch URL in browser
    // launch(url);
    print('Navigating to: $url');
  }
}
