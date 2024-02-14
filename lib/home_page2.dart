import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'custom_widget.dart';
import 'permission_handler.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool isEnglish = true;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter - Thermal Printer'),
        backgroundColor: Colors.redAccent,
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton.icon(
              onPressed: () async {
                await screenshotController.capture().then((Uint8List? image) async {
                  await PermissionHandlerPermissionService.handlePhotosPermission(context).then((bool photoPermission) async {
                    if (photoPermission == true) {
                      await ImageGallerySaver.saveImage(
                        image!,
                        quality: 100,
                      );
                      Fluttertoast.showToast(msg: 'Bill saved');
                    }
                  });
                });
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.sync,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            isEnglish = !isEnglish;
          });
        },
      ),
      body: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Center(
                            child: CustomWidgets.text(
                              isEnglish == true ? 'Water Bill' : 'ใบแจ้งหนี้ค่าน้ำประปา',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Center(
                            child: CustomWidgets.text(
                              isEnglish == true ? '(not a receipt)' : '(ไม่ใช่ใบเสร็จรับเงิน)',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: CustomWidgets.text(
                              isEnglish == true ? 'Bang Pahan Municipality' : 'เทศบาลตำบลบางปะหัน',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Center(
                            child: CustomWidgets.text(
                              isEnglish == true
                                  ? '90 Moo 6, Bang Pahan Subdistrict, Bang Pahan District \n Phra Nakhon Si Ayutthaya Province 13220 \n Phone : 035-301-777'
                                  : '90 หมู่ 6 ตำบลบางปะหัน อำเภอบางปะหัน \n จังหวัดพระนครศรีอยุธายา 13220 \n โทรศัพท์ : 035-301-777',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 140,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'invoice number' : 'เลขที่ใบแจ้งหนี้',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text('256600001'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'Water user number' : 'เลขที่ผู้ใช้น้ำ',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text('0001'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'Water bill date' : 'วันที่แจ้งค่าน้ำ',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text('07/04/2023'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'Due date' : 'วันครบกำหนดชำระ',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text('31/04/2023'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              CustomWidgets.text(
                                isEnglish == true ? 'Name   : ' : 'ชื่อ   : ',
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomWidgets.text(
                                  isEnglish == true ? 'Ms. Saving, very rich' : 'น.ส.ประหยัด รวยมาก',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomWidgets.text(
                                isEnglish == true ? 'address : ' : 'ที่อยู่ : ',
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomWidgets.text(
                                  isEnglish == true
                                      ? '999 Moo 1, Bang Pahan Subdistrict, Bang Pahan District Phra Nakhon Si Ayutthaya 13220'
                                      : '999 หมู่ 1 ตำบลบางปะหัน อำเภอบางปะหัน จังหวัดพระนครศรีอยุธยา 13220',
                                  maxLine: 2,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'Water usage information' : 'ข้อมูลการใช้น้ำ',
                                            fontWeight: FontWeight.w600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'Last time' : 'ครั้งก่อน',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'This time' : 'ครั้งนี้',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            isEnglish == true ? 'Date of reading numbers in the water meter' : 'วันเดือนปีที่อ่าน เลขในมาตรวัดน้ำ',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            '07/03/2023 \n1995',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const VerticalDivider(
                                        width: 0,
                                        thickness: 1,
                                        color: Colors.black,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: CustomWidgets.text(
                                            '07/04/2023 \n2010',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Water bill' : 'ค่าน้ำ',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '182.00',
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Discount' : 'ส่วนลด',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        ' 18.20',
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Water meter maintenance fee' : 'ค่ารักษามาตรวัดน้ำ',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '30.00',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Total monthly water bill' : 'รวมเงินค่าน้ำประปาประจำเดือน',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '193.80',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Overdue' : 'ค้างชำระ',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '0.00',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Exceeded water bill' : 'ค่าน้ำที่รับไว้เกิน',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '0.00',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'VAT 7%' : 'ภาษีมูลค่าเพิ่ม 7%',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '13.57',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 15,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomWidgets.text(
                                        isEnglish == true ? 'Total' : 'รวมทั้งสิ้น',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      CustomWidgets.text(
                                        '207.37',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomWidgets.text(
                              isEnglish == true
                                  ? '*Please pay all water bills by _______________ date. You may be suspended from using water.'
                                  : '*โปรดชำระเงินค่าน้ำทั้งหมดภายในวันที่_______________ถ้าเกินกำหนด ท่านอาจจะถูกระงับการใช้น้ำ',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'assets/images/qr.png',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Image.asset(
                                  'assets/images/qr.png',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: CustomWidgets.text(
                                  isEnglish == true ? 'QR Code for payment' : 'QR Code สำหรับชำระเงิน',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomWidgets.text(
                                  isEnglish == true
                                      ? 'When making payment,\nplease notify payment\nat this line.'
                                      : 'เมื่อชำระเงินแล้วกรุณาแจ้งชำระเงินได้ที่ Line นี้',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showCapturedWidget(BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) {
        /* Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });*/
        return AlertDialog(
          title: const Text('Save Quote to gallary'),
          elevation: 5,
          actions: [
            Center(
              child: Image.memory(capturedImage),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
