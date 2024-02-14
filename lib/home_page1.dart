import 'package:demo_blutooth_print/print_page1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'print_page2.dart';

class HomePage1 extends StatelessWidget {
  HomePage1({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> data = [
    {'title': 'Cadbury Dairy Milk', 'price': 15, 'qty': 2},
    {'title': 'Parle-G Gluco Biscut', 'price': 5, 'qty': 5},
    {'title': 'Fresh Onion - 1KG', 'price': 20, 'qty': 1},
    {'title': 'Fresh Sweet Lime', 'price': 20, 'qty': 5},
    {'title': 'Meggie', 'price': 10, 'qty': 5},
  ];
  final f = NumberFormat("\$#,##,###.00", "en_US");

  @override
  Widget build(BuildContext context) {
    int total = 0;
    total = data.map((e) => e['price'] * e['qty']).reduce((value, element) => value + element);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter - Thermal Printer'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    data[index]['title'].toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${f.format(data[index]['price'])} x ${data[index]['qty']}",
                  ),
                  trailing: Text(
                    f.format(data[index]['price'] * data[index]['qty']),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'Total: ${f.format(total)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrintPage1(data: data),
                        ),
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print 1'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PrintPage2(data: data),
                        ),
                      );
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print 2'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
