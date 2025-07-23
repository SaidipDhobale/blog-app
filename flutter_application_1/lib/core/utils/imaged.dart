import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
Future<File> downloadImageToFile(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;

    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/downloaded_image.jpg');

    return await file.writeAsBytes(bytes);
  } else {
    throw Exception('Failed to download image: ${response.statusCode}');
  }
}