import 'dart:convert';

import 'package:yml/models/device.dart';

class Device {
    String token;
    List<DeviceElement> device;

    Device({
        required this.token,
        required this.device,
    });

    factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

    

    factory Device.fromJson(Map<String, dynamic> json) => Device(
        token: json["token"],
        device: List<DeviceElement>.from(json["device"].map((x) => DeviceElement.fromJson(x))),
    );

   
}