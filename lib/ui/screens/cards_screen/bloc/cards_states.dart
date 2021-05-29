class CardsState {
  const CardsState._({this.status, this.nativeLang, this.studyLang});

  const CardsState.loading()
      : this._(
          status: CardsStatus.loading,
        );

  const CardsState.defaultState()
      : this._(
          status: CardsStatus.defaultState,
        );

  const CardsState.dataLoaded({String nativeLang, String studyLang})
      : this._(
          status: CardsStatus.dataLoaded,
          nativeLang: nativeLang,
          studyLang: studyLang,
        );

  const CardsState.failure()
      : this._(
          status: CardsStatus.failure,
        );

  final CardsStatus status;
  final String nativeLang;
  final String studyLang;
}

enum CardsStatus { dataLoaded, failure, defaultState, loading }
