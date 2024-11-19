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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextCustom(
                text: 'Dashboard',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
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
                  return const Center(child: Text('No Status Found'));
                }

                final statusCounts = snapshot.data!;
                final totalOrders = (statusCounts['Pending'] ?? 0) +
                    (statusCounts['Shipped'] ?? 0) +
                    (statusCounts['Delivered'] ?? 0);

                return Column(
                  children: [
                    Row(
                      children: [
                        Card(
                          color: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextCustom(
                                    text: 'Total Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '$totalOrders',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Card(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextCustom(
                                    text: 'Pending Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '${statusCounts['Pending'] ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Card(
                          color: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextCustom(
                                    text: 'Shipping Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '${statusCounts['Shipped'] ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Card(
                          color: Colors.purpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            height: 150,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextCustom(
                                    text: 'Completed Orders',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    '${statusCounts['Delivered'] ?? 0}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Pie Chart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 400,
                            width: 400,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: totalOrders.toDouble(),
                                    color: Colors.amberAccent,
                                    title: '$totalOrders',
                                    radius: 80,
                                    titleStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (statusCounts['Pending'] ?? 0)
                                        .toDouble(),
                                    color: Colors.blueAccent,
                                    title: '${statusCounts['Pending'] ?? 0}',
                                    radius: 80,
                                    titleStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (statusCounts['Shipped'] ?? 0)
                                        .toDouble(),
                                    color: Colors.greenAccent,
                                    title: '${statusCounts['Shipped'] ?? 0}',
                                    radius: 80,
                                    titleStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  PieChartSectionData(
                                    value: (statusCounts['Delivered'] ?? 0)
                                        .toDouble(),
                                    color: Colors.purpleAccent,
                                    title: '${statusCounts['Delivered'] ?? 0}',
                                    radius: 80,
                                    titleStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                sectionsSpace: 2, // Space between the sections
                                centerSpaceRadius:
                                    80, // Adjust center space for better spacing
                              ),
                            )),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
