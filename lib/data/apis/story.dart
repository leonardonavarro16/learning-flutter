import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:swc_front/data/apis/base.dart';
import 'package:swc_front/data/models/story.dart';

class StoryAPI extends BaseAPI {
  Future<List<Story>> createStory(Map<String, dynamic> storyData) async {
    try {
      // Convertir la imagen a bytes
      Uint8List imageBytes = storyData['image'];
      String imageUrl = await uploadImage(imageBytes);

      // Actualizar los datos con la URL de la imagen
      storyData['image'] = imageUrl;

      // Realizar la solicitud POST al API
      String apiUrl = '${baseUrl()}/stories';
      String requestBody = json.encode(storyData);
      http.Response response = await httpPost(apiUrl, body: requestBody);

      if (response.statusCode == 201) {
        // La historia se creó correctamente, se espera la respuesta del API
        Map<String, dynamic> responseData = json.decode(response.body);
        List<Story> createdStories = [];
        for (var data in responseData['stories']) {
          Story story = Story.fromMap(data);
          createdStories.add(story);
        }
        return createdStories;
      } else {
        throw Exception('Failed to create story');
      }
    } catch (error) {
      throw Exception('Failed to create story: $error');
    }
  }

  Future<String> uploadImage(Uint8List imageBytes) async {
    try {
      // Hacer la solicitud POST al API para cargar la imagen
      String uploadUrl = '${baseUrl()}/upload';
      http.StreamedResponse response = await formDataPut(
        uploadUrl,
        fields: {},
        files: {'image': imageBytes},
      );

      if (response.statusCode == 200) {
        // La imagen se cargó correctamente, se espera la respuesta del API
        String imageUrl =
            json.decode(await response.stream.bytesToString())['url'];
        return imageUrl;
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (error) {
      throw Exception('Failed to upload image: $error');
    }
  }
}
