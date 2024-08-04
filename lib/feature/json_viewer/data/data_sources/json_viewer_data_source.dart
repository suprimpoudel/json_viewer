import 'dart:io';

import 'package:dio/dio.dart';
import 'package:json_viewer/feature/common/utils/constants/error_constants.dart';

class JsonViewerDataSource {
  Future<Response<dynamic>?> fetchJsonValue(String url) async {
    var dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 20),
    ));

    try {
      return await dio.get(
        url,
        options: Options(
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 20),
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw Exception(ErrorConstants.internetIssueError);
      }
      return e.response;
    } on SocketException catch (_) {
      throw Exception(ErrorConstants.internetIssueError);
    } on IOException catch (_) {
      throw Exception(ErrorConstants.internetIssueError);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
