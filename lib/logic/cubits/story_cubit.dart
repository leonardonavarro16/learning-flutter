import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/repositories/story_repository.dart';
import 'package:swc_front/logic/states/stories.dart';

import '../../data/models/user.dart';

class StoryCubit extends Cubit<StoryState> {
  final StoryRepository _storyRepository = StoryRepository();

  StoryCubit() : super(StoryState.initial());

  Future<void> createStory(Story story, String? token) async {
    // try {
    //   emit(
    //     state.copyWith(status: StoryStatus.loading),
    //   );
    //   Story createdStory = await _storyRepository.createStory(story, token!);
    //   state.stories[].add(createdStory);
    //   emit(state.copyWith(
    //     status: StoryStatus.storySuccess,
    //     stories: state.stories,
    //   ));
    // } catch (error) {
    //   emit(
    //     state.copyWith(
    //       status: StoryStatus.failure,
    //       error: error.toString(),
    //     ),
    //   );
    // }
  }

  Future<void> fetchUserStories(String? token) async {
    emit(state.copyWith(status: StoryStatus.loading));
    if (state.stories[state.user_id]!.isEmpty) {
      List<Story> stories =
          await _storyRepository.fetchStories(token, state.user_id);
      state.stories[state.user_id] = stories;
    }
    try {
      // print('Print puesto en cubit; daleee ${stories.length}');
      emit(
        state.copyWith(
            status: StoryStatus.storySuccess, stories: state.stories),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: StoryStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> fetchAllStoriesUsers(String? token) async {
    emit(state.copyWith(status: StoryStatus.loading));
    List<User> storiesUsers = await _storyRepository.fetchStoriesUsers(token);
    Map<String, List<Story>>? stories = {};
    storiesUsers.forEach((user) {
      String storyUserId = user.id!;
      stories[storyUserId] = [];
    });
    try {
      emit(
        state.copyWith(
          status: StoryStatus.storySuccess,
          stories: stories,
          storiesUsers: storiesUsers,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: StoryStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  // Future<void> deleteStory(Story story) async {
  //   try {
  //     emit(state.copyWith(status: StoryStatus.loading));
  //     await _storyRepository.deleteStory(story);
  //     deleteStory(
  //         story); // Eliminar la historia del estado después de eliminarla en el backend
  //   } catch (e) {
  //     emit(state.copyWith(
  //         error: 'Error al eliminar la historia', status: StoryStatus.failure));
  //   }
  // }
}
