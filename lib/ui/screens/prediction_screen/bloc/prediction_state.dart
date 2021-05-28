class PredictionState {
  const PredictionState._(
      {this.status,
      this.recognations,
      this.translations,
      this.recognationsTranslations,
      this.studyLang});

  const PredictionState.loading()
      : this._(
          status: PredictionStatus.loading,
        );

  const PredictionState.defaultState()
      : this._(
          status: PredictionStatus.defaultState,
        );

  const PredictionState.dataLoaded(
      {List<dynamic> recognations,
      List<String> translations,
      List<String> recognationsTranslations,
      String studyLang})
      : this._(
          status: PredictionStatus.dataLoaded,
          recognations: recognations,
          translations: translations,
          recognationsTranslations: recognationsTranslations,
          studyLang: studyLang,
        );

  const PredictionState.dataSended()
      : this._(
          status: PredictionStatus.dataSended,
        );

  const PredictionState.failure()
      : this._(
          status: PredictionStatus.failure,
        );

  final PredictionStatus status;

  final List<dynamic> recognations;
  final List<String> translations;
  final List<String> recognationsTranslations;
  final String studyLang;
}

enum PredictionStatus { dataSended, dataLoaded, failure, defaultState, loading }
