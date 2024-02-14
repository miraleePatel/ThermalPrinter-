// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';

class PermissionHandlerPermissionService {
  static Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  static Future<PermissionStatus> requestStoragePermission() async {
    return await Permission.storage.request();
  }

  static Future<bool> handleCameraPermission(BuildContext context) async {
    PermissionStatus cameraPermissionStatus = await requestCameraPermission();

    if (cameraPermissionStatus == PermissionStatus.denied) {
      // errorSnackBar(message: "Camera Permission Denied!");
      Fluttertoast.showToast(msg: "Camera Permission Denied!");
      return false;
    } else if (cameraPermissionStatus == PermissionStatus.permanentlyDenied) {
      await permissionDialog(
        context,
        title: 'Camera Permission',
        subTitle: 'Camera permission should be granted to use this feature, would you like to go to app settings to give camera permission?',
        onTap: () {
          Navigator.of(context).pop();
          openAppSettings();
        },
      );
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> handlePhotosPermission(BuildContext context) async {
    if (Platform.isAndroid && sdkInt > 30) {
      return true;
    } else {
      PermissionStatus photosPermissionStatus = await requestStoragePermission();
      if (photosPermissionStatus == PermissionStatus.denied) {
        // errorSnackBar(message: "Photos Permission Denied!");
        Fluttertoast.showToast(msg: "Photos Permission Denied!");
        return false;
      } else if (photosPermissionStatus == PermissionStatus.permanentlyDenied) {
        await permissionDialog(
          context,
          title: 'Photos Permission',
          subTitle: 'Photos permission should be granted to use this feature, would you like to go to app settings to give photos permission?',
          onTap: () {
            Navigator.of(context).pop();
            openAppSettings();
          },
        );
        return false;
      } else {
        return true;
      }
    }
  }

  static Future<bool> handleStoragePermission(BuildContext context) async {
    if (Platform.isAndroid && sdkInt > 30) {
      return true;
    } else {
      PermissionStatus storagePermissionStatus = await requestStoragePermission();
      if (storagePermissionStatus == PermissionStatus.denied) {
        // errorSnackBar(message: "Storage Permission Denied!");
        Fluttertoast.showToast(msg: "Storage Permission Denied!");
        return false;
      } else if (storagePermissionStatus == PermissionStatus.permanentlyDenied) {
        await permissionDialog(
          context,
          title: 'Storage Permission',
          subTitle: 'Storage permission should be granted to use this feature, would you like to go to app settings to give storage permission?',
          onTap: () {
            Navigator.of(context).pop();
            openAppSettings();
          },
        );
        return false;
      } else {
        return true;
      }
    }
  }
}

Future permissionDialog(BuildContext context, {String? title, String? subTitle, Function()? onTap}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.only(top: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title!,
          textAlign: TextAlign.center,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              subTitle!,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Cancel",
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.only(top: 2, bottom: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        topLeft: Radius.circular(3),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: const Text(
                      textAlign: TextAlign.center,
                      "Confirm",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
