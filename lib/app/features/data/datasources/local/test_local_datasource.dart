import 'package:interior_ai/app/features/data/models/test_model.dart';
import 'package:interior_ai/core/logger/app_logger.dart';

abstract class TestLocalDatasource {
  Future<TestModel> getById({
    required String id,
  });
}

class TestLocalDatasourceImpl implements TestLocalDatasource {
  @override
  Future<TestModel> getById({
    required String id,
  }) {
    AppLogger.instance.error("Error");
    throw UnimplementedError();
  }
}
