import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:interior_ai/app/common/config/config.dart';
import 'package:interior_ai/core/dio_manager/api_response_model.dart';
import 'package:interior_ai/core/dio_manager/dio_manager.dart';

abstract class ImageGenerationRemoteDatasource {
  /// Sends a source image + prompt to the image model and returns the
  /// generated image as a base64 string.
  Future<ApiResponseModel<String>> generate({
    required String prompt,
    required String imageBase64,
    required String mimeType,
  });
}

/// Cloudflare Workers AI image-to-image (Stable Diffusion). Returns the
/// generated PNG bytes, re-encoded as base64 so the repository can persist it.
final class ImageGenerationRemoteDatasourceImpl
    implements ImageGenerationRemoteDatasource {
  final DioApiManager _dioApiManager =
      DioApiManager(baseUrl: Config.cloudflareRunBaseUrl);

  @override
  Future<ApiResponseModel<String>> generate({
    required String prompt,
    required String imageBase64,
    required String mimeType,
  }) async {
    return _dioApiManager.post<String>(
      '/${Config.cloudflareImageModel}',
      options: Options(
        responseType: ResponseType.bytes,
        headers: {'Authorization': 'Bearer ${Config.cloudflareApiToken}'},
      ),
      data: {
        'prompt': prompt,
        'image_b64': imageBase64,
        'strength': 0.65,
        'num_steps': 20,
      },
      converter: (data) => base64Encode(data as List<int>),
    );
  }
}
