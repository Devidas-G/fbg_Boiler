import 'package:fbg/core/providers/config_pr.dart';
import 'package:fbg/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class LocationProvider with ChangeNotifier {
  final ConfigModel _configModel = locator<ConfigModel>();
  double? _latitude;
  double? get latitude => _latitude;
  set latitude(double? newlatitude) {
    _latitude = newlatitude;
    notifyListeners();
  }

  double? _longitude;
  double? get longitude => _longitude;
  set longitude(double? newlongitude) {
    _longitude = newlongitude;
    notifyListeners();
  }

  bool _istracking = false;
  bool get istracking => _istracking;
  set istracking(bool newtracking) {
    _istracking = newtracking;
    notifyListeners();
  }

  Future<void> startTracking() async {
    istracking = true;
    bg.BackgroundGeolocation.start();
  }

  Future<void> stopTracking() async {
    istracking = false;
    bg.BackgroundGeolocation.stop();
  }
}
