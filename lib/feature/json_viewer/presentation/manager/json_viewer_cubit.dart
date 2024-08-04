import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_viewer/feature/common/di/app_module.dart';
import 'package:json_viewer/feature/json_viewer/domain/use_cases/json_viewer_use_case.dart';
import 'package:json_viewer/feature/json_viewer/presentation/manager/json_viewer_state.dart';
import 'package:json_viewer/feature/json_viewer/utils/json_validate_action.dart';

class JsonViewerCubit extends Cubit<JsonViewerState> {
  late JsonViewerUseCase _useCase;

  JsonViewerCubit() : super(JsonViewerIdleState()) {
    _useCase = locator.get<JsonViewerUseCase>();
  }

  void validateJsonAndPerformAction(
      String json, JsonValidateAction action) async {
    if (state is JsonViewerLoadingState) return;
    emit(JsonViewerLoadingState());
    await Future.delayed(const Duration(seconds: 0));
    try {
      var decodedJson = _useCase.validateJsonString(json);
      if (action == JsonValidateAction.removeWhiteSpace) {
        decodedJson = _useCase.removeWhiteSpace(decodedJson);
      } else if (action == JsonValidateAction.downloadJson) {
        _useCase.downloadJsonFile(decodedJson);
        emit(JsonViewerIdleState());
        return;
      }

      emit(JsonViewerValidatedState(decodedJson, action));
    } catch (e) {
      emit(JsonViewerErrorState(e));
      await Future.delayed(const Duration(seconds: 0));
      emit(JsonViewerIdleState());
    }
  }

  void copyValue(String text) async {
    if (state is JsonViewerLoadingState) return;
    emit(JsonViewerLoadingState());
    await Future.delayed(const Duration(seconds: 0));
    try {
      await _useCase.copyValue(text);
      emit(JsonViewerCopiedState());
    } catch (e) {
      emit(JsonViewerErrorState(e));
      await Future.delayed(const Duration(seconds: 0));
      emit(JsonViewerIdleState());
    }
  }

  void fetchJsonValue(String text) async {
    if (state is JsonViewerLoadingState) return;
    emit(JsonViewerLoadingState());
    await Future.delayed(const Duration(seconds: 0));
    try {
      var jsonString = await _useCase.fetchJsonValue(text);
      jsonString = _useCase.validateJsonString(jsonString);
      emit(JsonViewerValidatedState(jsonString, JsonValidateAction.format));
    } catch (e) {
      emit(JsonViewerErrorState(e));
      await Future.delayed(const Duration(seconds: 0));
      emit(JsonViewerIdleState());
    }
  }

  void pickFile() async {
    if (state is JsonViewerLoadingState) return;
    emit(JsonViewerLoadingState());
    await Future.delayed(const Duration(seconds: 0));
    try {
      var jsonString = await _useCase.pickFile();
      var decodedJson = _useCase.validateJsonString(jsonString);
      emit(JsonViewerValidatedState(decodedJson, JsonValidateAction.format));
    } catch (e) {
      emit(JsonViewerErrorState(e));
      await Future.delayed(const Duration(seconds: 0));
      emit(JsonViewerIdleState());
    }
  }

  void clearValue() async {
    if (state is JsonViewerLoadingState) return;
    emit(JsonViewerLoadingState());
    await Future.delayed(const Duration(seconds: 0));
    emit(JsonViewerClearedState());
  }

  viewSourceCode() async => _useCase.viewSourceCode();
}
