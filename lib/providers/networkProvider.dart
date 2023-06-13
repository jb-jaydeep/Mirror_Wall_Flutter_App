import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../model/networkModel.dart';

class NetworkProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();
  networkModel networkmodel = networkModel(NetworkStatus: "Waiting");

  void CheckInternet() {
    networkmodel.connectStream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.mobile:
          networkmodel.NetworkStatus = "mobile";
          notifyListeners();
          break;
        case ConnectivityResult.wifi:
          networkmodel.NetworkStatus = "Wifi";
          notifyListeners();
          break;
        case ConnectivityResult.bluetooth:
          networkmodel.NetworkStatus = "bluetooth";
          notifyListeners();
          break;
        case ConnectivityResult.ethernet:
          networkmodel.NetworkStatus = "ethernet";
          notifyListeners();
          break;
        case ConnectivityResult.vpn:
          networkmodel.NetworkStatus = "vpn";
          notifyListeners();
          break;
        default:
          networkmodel.NetworkStatus = "Waiting";
      }
    });
  }
}
