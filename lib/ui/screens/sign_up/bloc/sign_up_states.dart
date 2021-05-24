class SignUpState {
  const SignUpState._({this.status});

  const SignUpState.loading()
      : this._(
          status: SignUpStatus.loading,
        );

  const SignUpState.defaultState()
      : this._(
          status: SignUpStatus.defaultState,
        );

  const SignUpState.complited()
      : this._(
          status: SignUpStatus.complited,
        );

  const SignUpState.failure()
      : this._(
          status: SignUpStatus.failure,
        );

  final SignUpStatus status;
}

enum SignUpStatus { complited, failure, defaultState, loading }
