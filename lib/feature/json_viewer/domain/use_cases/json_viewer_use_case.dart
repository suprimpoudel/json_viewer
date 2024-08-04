import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:json_viewer/feature/common/utils/constants/environment_constants.dart';
import 'package:json_viewer/feature/json_viewer/domain/repositories/json_viewer_repository.dart';
import 'package:universal_html/html.dart' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class JsonViewerUseCase {
  final JsonViewerRepository _repository;

  JsonViewerUseCase(this._repository);

  String validateJsonString(String jsonData) {
    jsonData = jsonData.trim();
    if (jsonData.isEmpty) {
      throw Exception("Please enter a json value");
    }

    final json = jsonDecode(jsonData);
    return const JsonEncoder.withIndent('  ').convert(json);
  }

  String removeWhiteSpace(String jsonData) {
    final json = jsonDecode(jsonData.trim());
    return jsonEncode(json);
  }

  Future<void> copyValue(String text) async {
    text = text.trim();
    if (text.isEmpty) {
      throw Exception("Nothing to copy");
    }

    await Clipboard.setData(
      ClipboardData(text: text),
    );
  }

  Future<String> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json', 'doc', 'txt'],
    );

    if (result == null) throw Exception("File doesn't have any contents");

    PlatformFile file = result.files.first;

    if (file.bytes == null) {
      throw Exception("Unable to locate file");
    }

    Uint8List bytes = file.bytes!;
    String content = utf8.decode(bytes);

    return validateJsonString(content);
  }

  void downloadJsonFile(String jsonData) {
    final bytes = utf8.encode(jsonData);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "formatted_json.json")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  Future<String> fetchJsonValue(String url) async {
    _isValidUrl(url);

    return await _repository.fetchJsonValue(url).then((value) {
      return jsonEncode(value?.data);
    });
  }

  void _isValidUrl(String url) {
    url = url.trim();

    if (url.isEmpty) {
      throw Exception("Please enter a URL");
    }

    if (Uri.parse(url).host.isEmpty) {
      throw Exception("Please enter a valid URL");
    }
  }

  void viewSourceCode() async {
    try {
      var projectUrl = EnvironmentConstants.gitOrigin;
      final Uri url = Uri.parse(projectUrl);
      var canLaunchURL = await canLaunchUrl(url);
      if (canLaunchURL) {
        launchUrl(url);
      }
    } catch (e) {
      if (kDebugMode) log(e.toString());
    }
  }
}
