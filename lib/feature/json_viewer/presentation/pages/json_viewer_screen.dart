import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_viewer/feature/common/presentation/widgets/error_dialog.dart';
import 'package:json_viewer/feature/common/presentation/widgets/loading_circular_progress.dart';
import 'package:json_viewer/feature/common/utils/extensions/context_extension.dart';
import 'package:json_viewer/feature/json_viewer/presentation/manager/json_viewer_cubit.dart';
import 'package:json_viewer/feature/json_viewer/presentation/manager/json_viewer_state.dart';
import 'package:json_viewer/feature/json_viewer/presentation/widgets/enter_url_dialog.dart';
import 'package:json_viewer/feature/json_viewer/utils/json_validate_action.dart';

class JsonViewerScreen extends StatefulWidget {
  const JsonViewerScreen({super.key});

  @override
  State<JsonViewerScreen> createState() => _JsonViewerScreenState();
}

class _JsonViewerScreenState extends State<JsonViewerScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<JsonViewerCubit>();

    return Stack(
      children: [
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter JSON string here',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    FilledButton.icon(
                      icon: const Icon(Icons.reorder),
                      onPressed: () => cubit.validateJsonAndPerformAction(
                          _controller.text, JsonValidateAction.format),
                      label: const Text('Format'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.backspace),
                      onPressed: () => cubit.validateJsonAndPerformAction(
                          _controller.text,
                          JsonValidateAction.removeWhiteSpace),
                      label: const Text('Remove Whitespaces'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.copy),
                      onPressed: () => cubit.copyValue(_controller.text),
                      label: const Text('Copy'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.clear),
                      onPressed: () => cubit.clearValue(),
                      label: const Text('Clear'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.language),
                      onPressed: _openEnterURLDialog,
                      label: const Text('Fetch JSON Value'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.file_copy),
                      onPressed: () => cubit.pickFile(),
                      label: const Text('Pick JSON File'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.download),
                      onPressed: () => cubit.validateJsonAndPerformAction(
                          _controller.text, JsonValidateAction.downloadJson),
                      label: const Text('Download JSON File'),
                    ),
                    FilledButton.icon(
                      icon: const Icon(Icons.code),
                      onPressed: () => cubit.viewSourceCode(),
                      label: const Text('View Source Code'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        BlocConsumer<JsonViewerCubit, JsonViewerState>(
            listener: (context, state) {
          if (state is JsonViewerErrorState) {
            if (mounted) _showError(state.error);
          } else if (state is JsonViewerValidatedState) {
            _controller.text = state.formattedJSON;

            if (mounted) setState(() {});
          } else if (state is JsonViewerCopiedState) {
            if (mounted) {
              context.displaySnackbar("Successfully copied contents");
            }
          } else if (state is JsonViewerClearedState) {
            _controller.clear();
            // if (mounted) setState(() {});
          }
        }, builder: (context, state) {
          return state is JsonViewerLoadingState
              ? const LoadingCircularProgress()
              : const SizedBox();
        }),
      ],
    );
  }

  void _showError(dynamic error) async {
    return await showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        error: error,
      ),
    );
  }

  void _openEnterURLDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => const EnterUrlDialog(),
    ).then((value) {
      if (value is String) {
        context.read<JsonViewerCubit>().fetchJsonValue(value);
      }
    });
  }
}
