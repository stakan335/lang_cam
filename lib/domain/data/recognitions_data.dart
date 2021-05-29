class RecognitionsData {
  RecognitionsData({
    this.confidence,
    this.index,
    this.label,
    this.translation,
  });

  factory RecognitionsData.fromJson(Map<String, dynamic> json) {
    return RecognitionsData(
      confidence: json['confidence'],
      index: json['index'],
      label: json['label'],
    );
  }

  final double confidence;
  final int index;
  String label;
  String translation;
}
