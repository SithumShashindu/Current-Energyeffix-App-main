import 'dart:convert';
import 'package:energyeffix_app/Components/CustomAppBar.dart';
import 'package:energyeffix_app/Components/MyNavBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart'; // Importing fl_chart instead of charts_flutter
import 'Components/CustomDrawer.dart';

class UnitsCalculated {
  final String day;
  final double unit;

  UnitsCalculated(this.day, this.unit);
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<UnitsCalculated> data = [];

  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int units = 0;

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.128.198/login_sdgp/post.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        data = jsonData
            .map((item) =>
                UnitsCalculated(item['day'], double.parse(item['unit'])))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: CustomAppBar(
          appBar: AppBar(
            toolbarHeight: 120,
          ),
          title: "Analytics"),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(49, 54, 152, 244),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Prediction for your month',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.energy_savings_leaf_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        '$month $year',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$units',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Energy Usage for Month',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Text(
              'This Week Electricity Usage',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Center(
              child: Container(
                height: 320,
                padding: EdgeInsets.all(20),
                child: _buildBarChart(),
              ),
            ),
          ],
        ),
      ), 
    );
  }

  Widget _buildBarChart() {
    List<BarChartGroupData> series = List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: data[index].unit,
            //color: Colors.blue,
            width: 20,
          ),
        ],
      );
    });

    // Bar chart widget
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: _maxYValue(), // Max value for Y axis
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(color: Colors.white),
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              if (value.toInt() < data.length) {
                return data[value.toInt()].day; // Use day as bottom titles
              }
              return '';
            },
            getTextStyles: (value) => const TextStyle(color: Colors.white),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: series,
      ),
    );
  }

  // Method to calculate the maximum Y value for setting Y axis
  double _maxYValue() {
    if (data.isNotEmpty) {
      return data
              .map((e) => e.unit)
              .reduce((value, element) => value > element ? value : element) *
          1.2;
    }
    return 10; // Default value if data is empty
  }
}
