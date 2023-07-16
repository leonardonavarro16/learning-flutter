import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/models/user.dart';

import 'base.dart';

enum StoryStatus {
  initial,
  loading,
  storySuccess,
  failure,
}

class StoryState extends BaseState {
  final Map<String, List<Story>> stories;
  final String error;
  String user_id;
  final StoryStatus status;
  final int currentPage;
  final List<User> storiesUsers;

  StoryState({
    required this.storiesUsers,
    required this.stories,
    required this.user_id,
    required this.error,
    required this.status,
    required this.currentPage,
  });

  factory StoryState.initial() {
    return StoryState(
      stories: {},
      error: '',
      user_id: '',
      status: StoryStatus.initial,
      currentPage: 1,
      storiesUsers: [],
    );
  }

  StoryState copyWith({
    Map<String, List<Story>>? stories,
    String? error,
    String? user_id,
    StoryStatus? status,
    int? currentPage,
    List<User>? storiesUsers,
  }) {
    return StoryState(
      stories: stories ?? this.stories,
      error: error ?? this.error,
      user_id: user_id ?? this.user_id,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      storiesUsers: storiesUsers ?? this.storiesUsers,
    );
  }
}
