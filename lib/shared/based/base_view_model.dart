import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manabie_todolist/helpers/toast_helper.dart';

class BaseViewModel {
  void initState() {}
  void disposeState() {}

  @protected
  Future<bool> call(
    dynamic Function() handler, {
    String? defaultErrorMessage,
    bool toastOnError = true,
    bool background = false,
    Function(Object)? onError,
    bool isOffline = false,
  }) async {
    try {
      if (!background) {
        await EasyLoading.show(status: "Đang xử lý...");
      }
      final result = handler();
      if (result is Future) {
        await result;
      }
      if (!background) {
        await EasyLoading.dismiss();
      }
      return true;
    } catch (e) {
      if (!background) {
        await EasyLoading.dismiss();
      }

      if (toastOnError) {
        ToastHelper.showToast(msg: defaultErrorMessage ?? e.toString(), isTrue: false);
      }

      if (onError != null) {
        onError(e);
      }

      return false;
    }
  }
}
