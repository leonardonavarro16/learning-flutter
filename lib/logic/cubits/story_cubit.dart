import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/repositories/story_repository.dart';
import 'package:swc_front/logic/states/stories.dart';

class StoryCubit extends Cubit<StoryState> {
  final StoryRepository _storyRepository = StoryRepository();

  StoryCubit() : super(StoryState.initial());

  Future<void> createStory(Story story, String? token) async {
    try {
      emit(
        state.copyWith(status: StoryStatus.loading),
      );
      Story createdStory = await _storyRepository.createStory(story, token);
      state.stories.add(createdStory);
      emit(state.copyWith(
        status: StoryStatus.storySuccess,
        stories: state.stories,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: StoryStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> fetchStories(String? token) async {
    emit(state.copyWith(status: StoryStatus.loading));
    try {
      List<Story> stories = await _storyRepository.fetchStories(token);
      emit(
        state.copyWith(
          status: StoryStatus.storySuccess,
          stories: stories,
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
