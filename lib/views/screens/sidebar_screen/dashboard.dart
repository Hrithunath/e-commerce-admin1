import 'package:e_commerce_admin/view_model/provider/view_models/order.dart';
import 'package:e_commerce_admin/views/widgets/text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCount = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextCustom(
                  text: 'Dashboard', fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            FutureBuilder<Map<String, int>>(
                future: orderCount.fetchAllOderCount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No Status Found'));
                  }

                  print('Snapshot Data: ${snapshot.data}');
                  final statusCounts = snapshot.data!;

                  final totalOrders = (statusCounts['Pending'] ?? 0) +
                      (statusCounts['Shipped'] ?? 0) +
                      (statusCounts['Delivered'] ?? 0);

                  // Main title for Dashboard

                  // Row for the sales info card
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 150,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                    text: 'Total Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$totalOrders',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 255),
                                    Column(
                                      children: [
                                        Icon(Icons.arrow_upward,
                                            color: Colors.green),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 150,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextCustom(
                                    text: 'Pending Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                        text: '${statusCounts['Pending'] ?? 0}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    const SizedBox(width: 255),
                                    const Column(
                                      children: [
                                        Icon(Icons.arrow_upward,
                                            color: Colors.green),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 150,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                    text: 'Shipping Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                        text: '${statusCounts['Shipped'] ?? 0}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(width: 255),
                                    Column(
                                      children: [
                                        Icon(Icons.arrow_upward,
                                            color: Colors.green),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            height: 150,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                    text: 'Completed Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                        text:
                                            '${statusCounts['Delivered'] ?? 0}',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    SizedBox(width: 255),
                                    Column(
                                      children: [
                                        Icon(Icons.arrow_upward,
                                            color: Colors.green),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 500,
                            width: 700,
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceEvenly,
                                //                           titlesData: FlTitlesData(
                                //   bottomTitles: SideTitles(
                                //     showTitles: true,
                                //     getTitles: (value) {
                                //       switch (value.toInt()) {
                                //         case 0:
                                //           return 'Pending';
                                //         case 1:
                                //           return 'Shipped';
                                //         case 2:
                                //           return 'Completed';
                                //         case 3:
                                //           return 'Total';
                                //         default:
                                //           return '';
                                //       }
                                //     },
                                //     margin: 10,
                                //   ),
                                //   leftTitles: SideTitles(showTitles: true),
                                // ),
                                barGroups: [
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                      toY: (statusCounts['Pending'] ??
                                              0 + statusCounts['Shipped']! ??
                                              0 + statusCounts['Delivered']! ??
                                              0)
                                          .toDouble(),
                                    ),
                                  ]),
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                      toY: (statusCounts['Pending'] ?? 0)
                                          .toDouble(),
                                    ),
                                  ]),
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                      toY: (statusCounts['Shipped'] ?? 0)
                                          .toDouble(),
                                    ),
                                  ]),
                                  BarChartGroupData(x: 0, barRods: [
                                    BarChartRodData(
                                      toY: (statusCounts['Delivered'] ?? 0)
                                          .toDouble(),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
