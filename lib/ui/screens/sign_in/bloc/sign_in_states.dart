class SignInState {
  const SignInState._({this.status});

  const SignInState.loading()
      : this._(
          status: SignUpStatus.loading,
        );

  const SignInState.defaultState()
      : this._(
          status: SignUpStatus.defaultState,
        );

  const SignInState.complited()
      : this._(
          status: SignUpStatus.complited,
        );

  const SignInState.failure()
      : this._(
          status: SignUpStatus.failure,
        );

  final SignUpStatus status;
}

enum SignUpStatus { complited, failure, defaultState, loading }
