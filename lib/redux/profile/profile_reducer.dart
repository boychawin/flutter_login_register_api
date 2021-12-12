
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  ProfileState({
    this.profile = const { 'email': 'boychawin' }
  });

  ProfileState copyWith({required Map<String, dynamic> profile}) {
    return ProfileState(
      profile: profile
    );
  }
}

//reducer
ProfileState profileReducer(ProfileState state, dynamic action) {
  // if (action is ProfileAction) {
  //   return state.copyWith(
  //     profile: action.profileState.profile
  //   );
  // }
  return state;
}
