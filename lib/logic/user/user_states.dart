abstract class UserStates {}

class UserInitial extends UserStates {}

class UserLoading extends UserStates {}

class UserFailure extends UserStates {
  String msg = '';
  UserFailure({required this.msg});
}

class UserSuccess extends UserStates {
  String msg = '';
  UserSuccess({required this.msg});
}
