import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class IssLocator {
  final Client client;

  late Point<double> _position;
  Future<void>? _ongoingRequest;

  IssLocator(this.client);

  Point<double> get currentPosition => _position;

  Future<void> update() async {
    _ongoingRequest ??= _doUpdate();
    await _ongoingRequest;
    _ongoingRequest = null;
  }

  Future<void> _doUpdate() async {
    var uri = Uri.parse('http://api.open-notify.org/iss-now.json');
    var rs = await client.get(uri);
    var data = jsonDecode(rs.body);
    var latitude = double.parse(data['iss_position']['latitude'] as String);
    var longitude = double.parse(data['iss_position']['longitude'] as String);
    _position = Point<double>(latitude, longitude);
  }
}

class IssSpotter {
  final IssLocator locator;
  final Point<double> observer;

  IssSpotter(this.locator, this.observer);

  bool get isVisible {
    var distance = sphericalDistanceKm(locator.currentPosition, observer);
    return distance < 80.0;
  }
}

// Returns the distance, in kilometers.
double sphericalDistanceKm(Point<double> p1, Point<double> p2) {
  var dLat = _toRadian(p1.x - p2.x);
  var sLat = pow(sin(dLat / 2), 2);
  var dLng = _toRadian(p1.y - p2.y);
  var sLng = pow(sin(dLng / 2), 2);
  var cosALat = cos(_toRadian(p1.x));
  var cosBLat = cos(_toRadian(p2.x));
  var x = sLat + cosALat * cosBLat * sLng;
  var d = 2 * atan2(sqrt(x), sqrt(1 - x)) * _radiusOfEarth;
  debugPrint("$d");
  return d;
}

/// Radius of the earth in km.
const int _radiusOfEarth = 6371;
double _toRadian(num degree) => degree * pi / 180.0;
