import 'package:flutter_application_1/redux/profile/profile_action.dart';
import 'package:flutter_application_1/redux/profile/profile_reducer.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;

  ProfileState({this.profile = const {'user_email': ''}});

  ProfileState copyWith({required Map<String, dynamic> profile}) {
    return ProfileState(profile: profile);
  }
}

//reducer
ProfileState profileReducer(ProfileState state, dynamic action) {
  
  if (action is ProfileAction) {
    return state.copyWith(profile: action.profileState.profile);
  }
  return state;
}


