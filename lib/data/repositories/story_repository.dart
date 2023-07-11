import 'package:swc_front/data/apis/story.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/repositories/base.dart';

class StoryRepository extends BaseRepository {
  final StoryAPI _api = StoryAPI();

  Future<Story> createStory(Story story, String token) async {
    Map<String, dynamic> rawStory =
        await _api.createStory(story.toMap(), token);
    return Story.fromMap(rawStory);
  }

  Future<List<Story>> fetchStories(String? token) async {
    List<dynamic> rawStories = await _api.fetchStories(token);
    return rawStories.map<Story>((dynamic rawStories) {
      return Story.fromMap(rawStories);
    }).toList();
  }
}
