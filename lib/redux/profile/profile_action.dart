
import 'package:flutter_application_1/redux/profile/profile_reducer.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileAction {
  final ProfileState profileState;

  const ProfileAction(this.profileState);
}

//action
updateProfileAction(Map<String, dynamic> newProfile) {
  //logic for change state

  return ProfileAction(
    ProfileState(profile: newProfile)
  );
}