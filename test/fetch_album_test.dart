import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
// import 'package:mocito_demo/main.dart';
import 'package:mocito_demo/models/album.dart';
import 'package:mocito_demo/services/album_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response(
              '{"userId": 1, "id": 2, "title": "mock test"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('If error was thrown it will execute', () {
      final client = MockClient();

      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 400));

      expect(fetchAlbum(client), throwsException);
    });
  });

  group('Test widgets', () {});
}
