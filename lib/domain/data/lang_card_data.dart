import 'package:lang_cam/domain/data/recognitions_data.dart';
import 'package:meta/meta.dart';

class LangCardData {
  LangCardData({
    @required this.imageUrl,
    this.recognitions,
  });

  factory LangCardData.fromJson(Map<String, dynamic> json) {
    return LangCardData(
        imageUrl: json['imagePath'],
        recognitions: (json['recognitions'] as List)
            .map((data) => RecognitionsData.fromJson(data))
            .toList());
  }

  final String imageUrl;
  List<RecognitionsData> recognitions;
}
