import 'package:interior_ai/app/common/config/config.dart';
import 'package:interior_ai/core/dio_manager/api_response_model.dart';
import 'package:interior_ai/core/dio_manager/dio_manager.dart';

abstract class ImageGenerationRemoteDatasource {
  /// Sends a source image + prompt to the generation Worker and returns the
  /// generated image as a base64 string. [appUserId] identifies the RevenueCat
  /// customer whose credit the Worker spends.
  Future<ApiResponseModel<String>> generate({
    required String appUserId,
    required String prompt,
    required String imageBase64,
    String? referenceImageBase64,
  });
}

/// Calls the Roomora generation Worker (`POST /generate`). The Worker deducts
/// one RevenueCat credit, runs fal.ai, and returns `{ image_b64, balance }`.
/// A 402 means the user is out of credits (surfaced via the response status).
final class ImageGenerationRemoteDatasourceImpl
    implements ImageGenerationRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: Config.workerBaseUrl);

  @override
  Future<ApiResponseModel<String>> generate({
    required String appUserId,
    required String prompt,
    required String imageBase64,
    String? referenceImageBase64,
  }) async {
    return _dioApiManager.post<String>(
      '/generate',
      data: {
        'appUserId': appUserId,
        'prompt': prompt,
        'imageB64': imageBase64,
        if (referenceImageBase64 != null) 'refB64': referenceImageBase64,
      },
      converter: (data) {
        final map = data as Map;
        return (map['image_b64'] as String?) ?? '';
      },
    );
  }
}
