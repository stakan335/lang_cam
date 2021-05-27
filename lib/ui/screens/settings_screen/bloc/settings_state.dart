class SettingsState {
  const SettingsState._({this.status, this.nativeLang, this.studyLang});

  const SettingsState.loading()
      : this._(
          status: SettingsStatus.loading,
        );

  const SettingsState.defaultState()
      : this._(
          status: SettingsStatus.defaultState,
        );

  const SettingsState.dataLoaded({String nativeLang, String studyLang})
      : this._(
          status: SettingsStatus.dataLoaded,
          nativeLang: nativeLang,
          studyLang: studyLang,
        );

  const SettingsState.dataSended()
      : this._(
          status: SettingsStatus.dataSended,
        );

  const SettingsState.failure()
      : this._(
          status: SettingsStatus.failure,
        );

  final SettingsStatus status;
  final String nativeLang;
  final String studyLang;
}

enum SettingsStatus { dataSended, dataLoaded, failure, defaultState, loading }
