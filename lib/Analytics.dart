// import 'dart:convert';
// import 'package:energyeffix_app/Components/CustomAppBar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'Components/CustomDrawer.dart';

// class UnitsCalculated {
//   final String day;
//   final double unit;

//   UnitsCalculated(this.day, this.unit,);
// }

// class MyHomePage extends StatefulWidget {
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<UnitsCalculated> data = [];

//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final response = await http.get(Uri.parse('http://192.168.1.4/login_sdgp/post.php'));

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       setState(() {
//         data = jsonData.map((item) => UnitsCalculated(item['day'], double.parse(item['unit']))).toList();
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1D1E33),
//       appBar: CustomAppBar(appBar: AppBar(
//         toolbarHeight: 120,
//       ), title: "Analytics"),
//       drawer: CustomDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 2),
//             // Container(
//             //   decoration: BoxDecoration(
//             //     color: Colors.blueGrey[400],
//             //     borderRadius: BorderRadius.circular(40),
//             //     border: Border.all(color: Colors.blueGrey, width: 5), // Blue border
//             //   ),
//             //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
//             //   margin: EdgeInsets.only(left: 15, right: 15),
//             //   child: Column(
//             //     children: [
//             //       Text(
//             //         'Prediction for the month',
//             //         style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
//             //       ),
//             //       Text(
//             //         '(March 2024)',
//             //         style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
//             //       ),
//             //       SizedBox(height: 10),
//             //       Text(
//             //         'kWh:',
//             //         style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
//             //       ),
//             //     ],
//             //   ),
//             // ),



//             SizedBox(height: 5),
//             Text(
//               'This Week Electricity Usage',
//               style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 5),
//             Center(
//               child: Container(
//                 height: 320,
//                 padding: EdgeInsets.all(20),
//                 child: _buildBarChart(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBarChart() {
//     List<charts.Series<UnitsCalculated, String>> series = [
//       charts.Series(
//         id: 'Units',
//         data: data,
//         domainFn: (UnitsCalculated datum, _) => datum.day,
//         measureFn: (UnitsCalculated datum, _) => datum.unit,
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//       )
//     ];

//     Widget chart = Container(
//       margin: EdgeInsets.only(top: 30), // Add margin to the top
//       child: charts.BarChart(
//         series,
//         animate: true,
//         vertical: true,
//         flipVerticalAxis: false,
//         barRendererDecorator: charts.BarLabelDecorator<String>(),
//         domainAxis: charts.OrdinalAxisSpec(
//           renderSpec: charts.SmallTickRendererSpec(
//             labelStyle: charts.TextStyleSpec(color: charts.Color.white),
//             labelRotation: 45,
//             lineStyle: charts.LineStyleSpec(
//               color: charts.MaterialPalette.white, // Color of the x-axis line
//               thickness: 1, // Thickness of the x-axis line
//             ),
//             axisLineStyle: charts.LineStyleSpec(
//               color: charts.MaterialPalette.white, // Color of the x-axis line
//               thickness: 1, // Thickness of the x-axis line
//             ),
//           ),
//         ),
//         primaryMeasureAxis: charts.NumericAxisSpec(
//           renderSpec: charts.GridlineRendererSpec(
//             labelStyle: charts.TextStyleSpec(color: charts.Color.white),
//             lineStyle: charts.LineStyleSpec(
//               color: charts.MaterialPalette.white, // Color of the y-axis line
//               thickness: 1, // Thickness of the y-axis line
//             ),
//             axisLineStyle: charts.LineStyleSpec(
//               color: charts.MaterialPalette.white, // Color of the y-axis line
//               thickness: 1, // Thickness of the y-axis line
//             ),
//           ),
//         ),
//       ),
//     );

//     // Description box widget
//     Widget descriptionBox = Container(
//       padding: EdgeInsets.all(3),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey[400],
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'X axis = Day',
//             style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             'Y axis = Units',
//             style: TextStyle(fontSize: 12,color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );

//     // Stack to overlay the chart and the description box
//     return Stack(
//       children: [
//         chart,
//         Positioned(
//           top: 0,
//           right: 0,
//           child: descriptionBox,
//         ),
//       ],
//     );
//   }
// }