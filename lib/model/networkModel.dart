import 'dart:async';

class networkModel {
  String NetworkStatus;
  StreamSubscription? connectStream;
  networkModel({required this.NetworkStatus, this.connectStream});
}
