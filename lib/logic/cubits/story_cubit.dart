// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:swc_front/data/models/story.dart';
// import 'package:swc_front/data/repositories/story_repository.dart';
// import 'package:swc_front/logic/states/stories.dart';

// class StoryCubit extends Cubit<StoryState> {
//   // final StoryRepository _storyRepository = StoryRepository();
//   StoryCubit() : super(StoryState.initial());

//   // Método para cargar las historias

//   Future<void> createStory(Story story) async {
//     try {
//       emit(state.copyWith(status: StoryStatus.loading));
//       await _storyRepository.createStory(story);
//     } catch (error) {
//       emit(
//           state.copyWith(error: error.toString(), status: StoryStatus.failure));
//     }
//   }

//   // Future<void> deleteStory(Story story) async {
//   //   try {
//   //     emit(state.copyWith(status: StoryStatus.loading));
//   //     await _storyRepository.deleteStory(story);
//   //     deleteStory(
//   //         story); // Eliminar la historia del estado después de eliminarla en el backend
//   //   } catch (e) {
//   //     emit(state.copyWith(
//   //         error: 'Error al eliminar la historia', status: StoryStatus.failure));
//   //   }
//   // }
// }
