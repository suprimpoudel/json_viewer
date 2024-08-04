import 'package:dio/dio.dart';

abstract class JsonViewerRepository {
  Future<Response<dynamic>?> fetchJsonValue(String url);
}