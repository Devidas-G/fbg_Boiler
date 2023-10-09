import 'dart:math';

import 'package:fbg/core/providers/location_pr.dart';
import 'package:fbg/core/services/config_s.dart';
import 'package:fbg/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:provider/provider.dart';

class ConfigModel with ChangeNotifier {
  final ConfigService _configService = locator<ConfigService>();

  void configurelocationplugin() {
    _configService.configureLocationPlugin();
  }

  bg.Location? _location;
  bg.Location? _motionlocation;
  bg.ProviderChangeEvent? _providerChangeEvent;

  bg.Location? get location => _location;
  set location(bg.Location? newlocation) {
    _location = newlocation;
    notifyListeners();
  }

  bg.Location? get motionlocation => _motionlocation;
  set motionlocation(bg.Location? newmotionlocation) {
    _motionlocation = newmotionlocation;
    notifyListeners();
  }

  bg.ProviderChangeEvent? get providerChangeEvent => _providerChangeEvent;
  set providerChangeEvent(bg.ProviderChangeEvent? newproviderChangeEvent) {
    _providerChangeEvent = newproviderChangeEvent;
    notifyListeners();
  }

  void activateLocationListners() {}

  void _onLocation(bg.Location newlocation) {
    location = newlocation;
    print(location);
  }

  void _onMotionChange(bg.Location location) {
    motionlocation = location;
  }

  void _onProviderChange(bg.ProviderChangeEvent event) {
    providerChangeEvent = event;
  }
}
