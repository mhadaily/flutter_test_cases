import 'package:flutter_test_cases/album.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 1. Add this import to include the generated file
import 'album_test.mocks.dart';

// 2. Generate a MockClient using the @GenerateMocks annotation.
@GenerateMocks([http.Client])
void main() {
  // Use a group to organize tests for the same class
  group('AlbumService', () {
    test(
      'returns an Album when the http call completes successfully',
      () async {
        // 3. Create the MockClient
        final client = MockClient();
        final service = AlbumService(client);

        // 4. Stub the get() call to return a successful response.
        when(client.get(Uri.parse('https://example.com/albums/1'))).thenAnswer(
          (_) async => http.Response('{"id": 1, "title": "Mock Album"}', 200),
        );

        // 5. Assert that the service returns a valid Album
        expect(await service.fetchAlbum(), isA<Album>());
      },
    );

    test('throws an exception on a server error', () {
      final client = MockClient();
      final service = AlbumService(client);

      // Stub the get() call to return an error response.
      when(
        client.get(Uri.parse('https://example.com/albums/1')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      // Assert that the service throws an exception.
      expect(service.fetchAlbum(), throwsException);
    });
  });
}
