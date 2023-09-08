import 'package:swc_front/data/models/story.dart';
import 'package:swc_front/data/models/user.dart';

import 'base.dart';

enum StoryStatus {
  initial,
  loading,
  indexSuccess,
  indexFailure,
  createSuccess,
  createFailure,
}

class StoryState extends BaseState {
  final Map<String, List<Story>> stories;
  final String error;
  String userId;
  final StoryStatus status;
  final int currentPage;
  final List<User> storiesUsers;

  StoryState({
    required this.storiesUsers,
    required this.stories,
    required this.userId,
    required this.error,
    required this.status,
    required this.currentPage,
  });

  factory StoryState.initial() {
    return StoryState(
      stories: {},
      error: '',
      userId: '',
      status: StoryStatus.initial,
      currentPage: 1,
      storiesUsers: [],
    );
  }

  StoryState copyWith({
    Map<String, List<Story>>? stories,
    String? error,
    String? userId,
    StoryStatus? status,
    int? currentPage,
    List<User>? storiesUsers,
  }) {
    return StoryState(
      stories: stories ?? this.stories,
      error: error ?? this.error,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      storiesUsers: storiesUsers ?? this.storiesUsers,
    );
  }
}
