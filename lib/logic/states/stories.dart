import 'package:swc_front/data/models/story.dart';

import 'base.dart';

enum StoryStatus {
  initial,
  loading,
  storySuccess,
  failure,
}

class StoryState extends BaseState {
  final List<Story> stories;
  final String error;
  final StoryStatus status;
  final int currentPage;

  StoryState({
    required this.stories,
    required this.error,
    required this.status,
    required this.currentPage,
  });

  factory StoryState.initial() {
    return StoryState(
      stories: [],
      error: '',
      status: StoryStatus.initial,
      currentPage: 1,
    );
  }

  StoryState copyWith({
    List<Story>? stories,
    String? error,
    StoryStatus? status,
    int? currentPage,
  }) {
    return StoryState(
      stories: stories ?? this.stories,
      error: error ?? this.error,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
