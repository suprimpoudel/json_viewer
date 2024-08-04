import 'package:dio/dio.dart';
import 'package:json_viewer/feature/json_viewer/data/data_sources/json_viewer_data_source.dart';
import 'package:json_viewer/feature/json_viewer/domain/repositories/json_viewer_repository.dart';

class JsonViewerRepositoryImpl implements JsonViewerRepository {
  final JsonViewerDataSource _dataSource;

  JsonViewerRepositoryImpl(this._dataSource);

  @override
  Future<Response<dynamic>?> fetchJsonValue(String url) async =>
      await _dataSource.fetchJsonValue(url).then((value) {
        return value;
      });
}
