import 'package:flutter/material.dart';
import 'package:manabie_todolist/shared/based/base_view_model.dart';

abstract class BaseViewState<T extends StatefulWidget, M extends BaseViewModel> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  late M _viewModel;

  M get viewModel => _viewModel;

  @override
  bool get wantKeepAlive => true;

  @protected
  void loadArguments() {}

  @protected
  M createViewModel();

  @override
  void initState() {
    _viewModel = createViewModel();

    super.initState();
    loadArguments();
    _viewModel.initState();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadArguments();
  }

  @override
  void dispose() {
    _viewModel.disposeState();
    super.dispose();
  }
}
