class NavigationState {
  final String? error;
  final int selectedIndex;

  NavigationState({
    this.error,
    required this.selectedIndex,
  });

  factory NavigationState.initial() {
    return NavigationState(
      error: null,
      selectedIndex: 0,
    );
  }

  NavigationState copyWith({
    String? error,
    int? selectedIndex,
  }) {
    return NavigationState(
      error: error ?? this.error,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
