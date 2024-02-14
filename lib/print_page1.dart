import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrintPage1 extends StatefulWidget {
  final List<Map<String, dynamic>>? data;
  const PrintPage1({Key? key, this.data}) : super(key: key);

  @override
  State<PrintPage1> createState() => _PrintPage1State();
}

class _PrintPage1State extends State<PrintPage1> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  List<BluetoothDevice> devices = [];
  bool connected = false;
  String deviceMsg = '';
  final f = NumberFormat('\$#,##,###.00', 'en_US');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrinter());
  }

  Future<void> initPrinter() async {
    if (!mounted) return;
    {
      bluetoothPrint.scanResults.listen((event) {
        if (!mounted) return;
        setState(() => {devices = event});
        if (devices.isEmpty) {
          setState(() {
            deviceMsg = 'No Devices';
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Printer'),
        backgroundColor: Colors.redAccent,
      ),
      body: devices.isEmpty
          ? Center(
              child: Text(deviceMsg),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1), () async {
                  initPrinter();
                });
              },
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: devices[index].connected == true ? Colors.green.shade100 : Colors.red.shade100,
                    leading: const Icon(Icons.print),
                    title: Text(devices[index].name!),
                    subtitle: Text(devices[index].address!),
                    onTap: () async {
                      await startPrint(devices[index]);
                    },
                  );
                },
              ),
            ),
    );
  }

  Future<void> startPrint(BluetoothDevice device) async {
    if (device.address != null && device.address != '') {
      await bluetoothPrint.connect(device);
    }
    Map<String, dynamic> config = {};
    List<LineText> list = [];
    list.add(
      LineText(
        type: LineText.TYPE_TEXT,
        content: 'Grocery App',
        weight: 2,
        height: 2,
        width: 2,
        align: LineText.ALIGN_CENTER,
        linefeed: 1,
      ),
    );
    for (var i = 0; i < widget.data!.length; i++) {
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: widget.data![i]['title'],
          weight: 0,
          align: LineText.ALIGN_LEFT,
          linefeed: 1,
        ),
      );
      list.add(
        LineText(
          type: LineText.TYPE_TEXT,
          content: "${f.format(widget.data![i]['price'])} x ${widget.data![i]['qty']}",
          align: LineText.ALIGN_LEFT,
          linefeed: 1,
        ),
      );
    }
    await bluetoothPrint.printReceipt(config, list);
  }
}
