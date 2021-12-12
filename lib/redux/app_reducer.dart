
import 'package:flutter_application_1/redux/profile/profile_reducer.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ProfileState profileState;

  AppState({
    required this.profileState
  });

  factory AppState.initial() {
    return AppState(
      profileState: ProfileState()
    );
  }

}

//reducer
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    profileState: profileReducer(state.profileState, action)
  );
}