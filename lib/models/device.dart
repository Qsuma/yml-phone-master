import 'dart:convert';

class DeviceElement {
    String deviceId;
    String device;

    DeviceElement({
        required this.deviceId,
        required this.device,
    });

    factory DeviceElement.fromRawJson(String str) => DeviceElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeviceElement.fromJson(Map<String, dynamic> json) => DeviceElement(
        deviceId: json["device_id"],
        device: json["device"],
    );

    Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "device": device,
    };
}