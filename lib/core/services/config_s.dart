import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class ConfigService {
  void configureLocationPlugin() {}
}

void backgroundGeolocationHeadlessTask(bg.HeadlessEvent headlessEvent) async {
  print('📬 --> $headlessEvent');

  switch (headlessEvent.name) {
    case bg.Event.BOOT:
      bg.State state = await bg.BackgroundGeolocation.state;
      print("📬 didDeviceReboot: ${state.didDeviceReboot}");
      break;
    case bg.Event.TERMINATE:
      bg.State state = await bg.BackgroundGeolocation.state;
      if (state.stopOnTerminate!) {
        // Don't request getCurrentPosition when stopOnTerminate: true
        return;
      }
      try {
        bg.Location location =
            await bg.BackgroundGeolocation.getCurrentPosition(
                samples: 1, extras: {"event": "terminate", "headless": true});
        print("[getCurrentPosition] Headless: $location");
      } catch (error) {
        print("[getCurrentPosition] Headless ERROR: $error");
      }

      break;
    case bg.Event.HEARTBEAT:
      try {
        bg.Location location =
            await bg.BackgroundGeolocation.getCurrentPosition(
                samples: 2,
                timeout: 10,
                extras: {"event": "heartbeat", "headless": true});

        print('[getCurrentPosition] Headless: $location');
      } catch (error) {
        print('[getCurrentPosition] Headless ERROR: $error');
      }
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      print(location);
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      print(location);
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      print(geofenceEvent);
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      print(state);
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      print(response);
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      print(enabled);
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      print(enabled);
      break;
    case bg.Event.AUTHORIZATION:
      bg.AuthorizationEvent event = headlessEvent.event;
      print(event);
      bg.BackgroundGeolocation.setConfig(
          bg.Config(url: "https://tracker.transistorsoft.com/api/locations"));
      break;
  }
}

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;

  // Is this a background_fetch timeout event?  If so, simply #finish and bail-out.
  if (task.timeout) {
    print("[BackgroundFetch] HeadlessTask TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] HeadlessTask: $taskId");

  try {
    var location = await bg.BackgroundGeolocation.getCurrentPosition(
        samples: 2, extras: {"event": "background-fetch", "headless": true});
    print("[location] $location");
  } catch (error) {
    print("[location] ERROR: $error");
  }

  int count = 0;

  print('[BackgroundFetch] count: $count');

  BackgroundFetch.finish(taskId);
}
