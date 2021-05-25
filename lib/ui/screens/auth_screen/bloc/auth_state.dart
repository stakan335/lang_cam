class AuthState {
  const AuthState._({this.status});

  const AuthState.loading()
      : this._(
          status: AuthStatus.loading,
        );

  const AuthState.defaultState()
      : this._(
          status: AuthStatus.defaultState,
        );

  const AuthState.signedIn()
      : this._(
          status: AuthStatus.signedIn,
        );

  const AuthState.failure()
      : this._(
          status: AuthStatus.failure,
        );

  final AuthStatus status;
}

enum AuthStatus { signedIn, failure, defaultState, loading }
