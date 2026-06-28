import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:interior_ai/app/features/data/datasources/remote/image_generation_remote_datasource.dart';
import 'package:interior_ai/core/logger/app_logger.dart';
import 'package:interior_ai/core/result/result.dart';
import 'package:path_provider/path_provider.dart';

abstract class ImageGenerationRepository {
  /// Generates a redesigned image from [sourceImagePath] (an asset path or a
  /// device file path) guided by [prompt]. On success returns the file path of
  /// the saved result image.
  Future<DataResult<String>> generate({
    required String prompt,
    required String sourceImagePath,
  });
}

final class ImageGenerationRepositoryImpl implements ImageGenerationRepository {
  final ImageGenerationRemoteDatasource _remoteDatasource;

  ImageGenerationRepositoryImpl({
    required ImageGenerationRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<DataResult<String>> generate({
    required String prompt,
    required String sourceImagePath,
  }) async {
    try {
      final bytes = await _readBytes(sourceImagePath);
      final response = await _remoteDatasource.generate(
        prompt: prompt,
        imageBase64: base64Encode(bytes),
        mimeType: _mimeTypeFor(sourceImagePath),
      );

      if (!response.isSuccess) {
        final message = response.error?.message ?? 'Generation failed';
        AppLogger.instance.error('$runtimeType generate() $message');
        return ErrorDataResult(message: message);
      }
      final base64Result = response.data;
      if (base64Result == null || base64Result.isEmpty) {
        AppLogger.instance.error('$runtimeType generate() empty image data');
        return ErrorDataResult(message: 'No image returned');
      }

      final path = await _saveImage(base64Decode(base64Result));
      AppLogger.instance.log('$runtimeType generate() SUCCESS');
      return SuccessDataResult(data: path, message: '$runtimeType generate()');
    } catch (error) {
      AppLogger.instance.error('$runtimeType generate() $error');
      return ErrorDataResult(message: 'Generation failed');
    }
  }

  Future<List<int>> _readBytes(String path) async {
    if (path.startsWith('assets/')) {
      final data = await rootBundle.load(path);
      return data.buffer.asUint8List();
    }
    return File(path).readAsBytes();
  }

  String _mimeTypeFor(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    return 'image/jpeg';
  }

  Future<String> _saveImage(List<int> bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final fileName = 'gen_${DateTime.now().microsecondsSinceEpoch}.png';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
