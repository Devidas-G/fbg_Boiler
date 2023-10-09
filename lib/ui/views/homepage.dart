import 'package:fbg/core/providers/config_pr.dart';
import 'package:fbg/core/providers/location_pr.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationProvider _locationProvider;

  @override
  void initState() {
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print(
          '[latitude] - ${location.coords.latitude}, [longitude] - ${location.coords.longitude}');
      _locationProvider.latitude = location.coords.latitude;
      _locationProvider.longitude = location.coords.longitude;
    });

    // // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    // bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
    //   //print('[motionchange] - $location');
    // });

    // // Fired whenever the state of location-services changes.  Always fired at boot
    // bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
    //   //print('[providerchange] - $event');
    // });

    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            distanceFilter: 10.0,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        //bg.BackgroundGeolocation.start();
      }
    });

    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   bg.BackgroundGeolocation.removeListeners();
  // }

  void _onClickEnable(enabled) {
    if (enabled) {
      // Reset odometer.
      bg.BackgroundGeolocation.start().then((bg.State state) {
        print('[start] success $state');
        _locationProvider.istracking = state.enabled;
      }).catchError((error) {
        print('[start] ERROR: $error');
      });
    } else {
      bg.BackgroundGeolocation.stop().then((bg.State state) {
        print('[stop] success: $state');
        _locationProvider.istracking = state.enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FBG_Boiler",
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              ExpansionTile(
                childrenPadding: EdgeInsets.all(10),
                title: Text("Track Location Coordinate"),
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text("Latitude:"),
                          Text("${_locationProvider.latitude}")
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Text("Longitude:"),
                          Text("${_locationProvider.longitude}")
                        ],
                      )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _locationProvider.istracking
                                  ? Colors.deepPurple
                                  : null),
                          onPressed: () {
                            _onClickEnable(!_locationProvider.istracking);
                          },
                          child: Text(
                            _locationProvider.istracking
                                ? "Stop Tracking"
                                : "Start Tracking",
                            style: TextStyle(
                                color: _locationProvider.istracking
                                    ? Colors.white
                                    : null),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ))
        ],
      )),
    );
  }
}
