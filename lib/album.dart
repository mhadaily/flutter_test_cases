import 'dart:convert';
import 'package:http/http.dart' as http;

class Album {
  final String title;
  const Album({required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(title: json['title']);
  }
}

class AlbumService {
  final http.Client client;

  AlbumService(this.client);

  Future<Album> fetchAlbum() async {
    final response = await client.get(
      Uri.parse('https://example.com/albums/1'),
    );
    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
