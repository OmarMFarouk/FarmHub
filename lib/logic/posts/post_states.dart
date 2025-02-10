abstract class PostStates {}

class PostInitial extends PostStates {}

class PostLoading extends PostStates {}

class PostFailure extends PostStates {
  String msg = '';
  PostFailure({required this.msg});
}

class PostSuccess extends PostStates {
  String msg = '';
  PostSuccess({required this.msg});
}
