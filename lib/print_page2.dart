// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PrintPage2 extends StatefulWidget {
  final List<Map<String, dynamic>>? data;
  const PrintPage2({Key? key, this.data}) : super(key: key);

  @override
  State<PrintPage2> createState() => _PrintPage2State();
}

class _PrintPage2State extends State<PrintPage2> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  List<BluetoothDevice> devices = [];
  bool connected = false;
  BluetoothDevice? device;
  String deviceMsg = '';
  final f = NumberFormat('\$#,##,###.00', 'en_US');
  Map<String, dynamic> config = {};
  List<LineText> list = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrinter());
  }

  Future<void> initPrinter() async {
    await bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((event) {
      switch (event) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            connected = true;
            deviceMsg = 'Connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            connected = false;
            deviceMsg = 'Disconnect success';
          });
          break;
        default:
          break;
      }
    });
    if (!mounted) return;

    if (isConnected) {
      setState(() {
        connected = true;
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
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              onPressed: () {
                bluetoothPrint.stopScan();
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () async {
                setState(() {
                  connected = false;
                });
                await bluetoothPrint.startScan(timeout: const Duration(seconds: 4));
              },
            );
          }
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(deviceMsg),
                  ),
                ],
              ),
              const Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name ?? ''),
                            subtitle: Text(d.address ?? ''),
                            onTap: () async {
                              setState(() {
                                device = d;
                              });
                            },
                            trailing: device != null && device!.address == d.address
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : null,
                          ))
                      .toList(),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: connected
                              ? null
                              : () async {
                                  if (device != null && device!.address != null) {
                                    setState(() {
                                      deviceMsg = 'Connecting...';
                                    });
                                    await bluetoothPrint.connect(device!);
                                    print(await bluetoothPrint.isConnected);
                                    bluetoothPrint.state.listen((event) {
                                      switch (event) {
                                        case BluetoothPrint.CONNECTED:
                                          setState(() {
                                            connected = true;
                                            deviceMsg = 'Connect success';
                                          });
                                          break;
                                        case BluetoothPrint.DISCONNECTED:
                                          setState(() {
                                            connected = false;
                                            deviceMsg = 'Disconnect success';
                                          });
                                          break;
                                        default:
                                          break;
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      deviceMsg = 'Please select device';
                                    });
                                    print('Please select device');
                                  }
                                },
                          child: const Text('Connect'),
                        ),
                        const SizedBox(width: 10.0),
                        OutlinedButton(
                          onPressed: connected
                              ? () async {
                                  setState(() {
                                    deviceMsg = 'Disconnecting...';
                                  });
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                          child: const Text('Disconnect'),
                        ),
                      ],
                    ),
                    const Divider(),
                    OutlinedButton(
                      onPressed: connected
                          ? () async {
                              Map<String, dynamic> config = {};
                              List<LineText> list = [];
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '**********************************************',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  linefeed: 1,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '打印单据头',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  fontZoom: 2,
                                  linefeed: 1,
                                ),
                              );
                              list.add(LineText(linefeed: 1));
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '----------------------明细---------------------',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  linefeed: 1,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '物资名称规格型号',
                                  weight: 1,
                                  align: LineText.ALIGN_LEFT,
                                  x: 0,
                                  relativeX: 0,
                                  linefeed: 0,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '单位',
                                  weight: 1,
                                  align: LineText.ALIGN_LEFT,
                                  x: 350,
                                  relativeX: 0,
                                  linefeed: 0,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '数量',
                                  weight: 1,
                                  align: LineText.ALIGN_LEFT,
                                  x: 500,
                                  relativeX: 0,
                                  linefeed: 1,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '混凝土C30',
                                  align: LineText.ALIGN_LEFT,
                                  x: 0,
                                  relativeX: 0,
                                  linefeed: 0,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '吨',
                                  align: LineText.ALIGN_LEFT,
                                  x: 350,
                                  relativeX: 0,
                                  linefeed: 0,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '12.0',
                                  align: LineText.ALIGN_LEFT,
                                  x: 500,
                                  relativeX: 0,
                                  linefeed: 1,
                                ),
                              );
                              list.add(
                                LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '**********************************************',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  linefeed: 1,
                                ),
                              );
                              list.add(LineText(linefeed: 1));
                              // ByteData data = await rootBundle.load("assets/images/bluetooth_print.png");
                              // List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                              // String base64Image = base64Encode(imageBytes);
                              // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));
                              await bluetoothPrint.printReceipt(config, list);
                            }
                          : null,
                      child: const Text('Print Receipt'),
                    ),
                    OutlinedButton(
                      onPressed: connected
                          ? () async {
                              Map<String, dynamic> config = {};
                              config['width'] = 40;
                              config['height'] = 70;
                              config['gap'] = 2;
                              List<LineText> list = [];
                              list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 10, content: 'A Title'));
                              list.add(LineText(type: LineText.TYPE_TEXT, x: 10, y: 40, content: 'this is content'));
                              list.add(LineText(type: LineText.TYPE_QRCODE, x: 10, y: 70, content: 'qrcode i\n'));
                              list.add(LineText(type: LineText.TYPE_BARCODE, x: 10, y: 190, content: 'qrcode i\n'));

                              List<LineText> list1 = [];
                              ByteData data = await rootBundle.load("assets/images/guide3.png");
                              List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                              String base64Image = base64Encode(imageBytes);
                              list1.add(LineText(type: LineText.TYPE_IMAGE, x: 10, y: 10, content: base64Image));

                              await bluetoothPrint.printLabel(config, list);
                              await bluetoothPrint.printLabel(config, list1);
                            }
                          : null,
                      child: const Text('print Label'),
                    ),
                    OutlinedButton(
                      onPressed: connected
                          ? () async {
                              await bluetoothPrint.printTest();
                            }
                          : null,
                      child: const Text('Print Self-Test'),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
