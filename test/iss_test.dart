import 'dart:math';

// import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocito_demo/iss.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
// import '../lib/iss.dart';
import 'iss_test.mocks.dart';

@GenerateMocks([IssLocator])
void main() {
  group('Spherical distance', () {
    test('London - Paris', () {
      var london = const Point(51.5073, -0.1277);
      var paris = const Point(48.8566, 2.3522);
      var d = sphericalDistanceKm(london, paris);
      expect(d, closeTo(343.5, 0.1));
    });

    test('San Francisco - Mountain View', () {
      var sf = const Point(37.783333, -122.416667);
      var mtv = const Point(37.389444, -122.081944);
      var d = sphericalDistanceKm(sf, mtv);
      expect(d, closeTo(52.8, 0.1));
    });
  });

  group('ISS spotter', () {
    test('ISS visible', () async {
      var sf = const Point(37.783333, -122.416667);
      var mtv = const Point(37.389444, -122.081944);
      IssLocator locator = MockIssLocator();
      mockito.when(locator.currentPosition).thenReturn(sf);

      var spotter = IssSpotter(locator, mtv);
      expect(spotter.isVisible, true);
    });

    test('ISS not visible', () async {
      var london = const Point(51.5073, -0.1277);
      var mtv = const Point(37.389444, -122.081944);
      IssLocator locator = MockIssLocator();
      mockito.when(locator.currentPosition).thenReturn(london);

      var spotter = IssSpotter(locator, mtv);
      expect(spotter.isVisible, false);
    });
  });
}
