import 'package:equatable/equatable.dart';
import 'package:json_viewer/feature/json_viewer/utils/json_validate_action.dart';

abstract class JsonViewerState extends Equatable {
  const JsonViewerState();

  @override
  List<Object?> get props => [];
}

class JsonViewerIdleState extends JsonViewerState {}

class JsonViewerLoadingState extends JsonViewerState {}
class JsonViewerCopiedState extends JsonViewerState {}
class JsonViewerClearedState extends JsonViewerState {}

class JsonViewerValidatedState extends JsonViewerState {
  final String _formattedJSON;
  final JsonValidateAction _action;

  const JsonViewerValidatedState(this._formattedJSON, this._action);

  String get formattedJSON => _formattedJSON;

  JsonValidateAction get action => _action;
}

class JsonViewerErrorState extends JsonViewerState {
  final dynamic _error;

  const JsonViewerErrorState(this._error);

  dynamic get error => _error;
}
