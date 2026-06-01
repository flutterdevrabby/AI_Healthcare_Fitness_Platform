import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class AddDeviceRx extends RxResponseInt<Map> {
  final api = AddDeviceApi.instance;

  AddDeviceRx({required super.empty, required super.dataFetcher});

  ValueStream<Map> get signupRxStream => dataFetcher.stream;

  Future<bool> addDeviceRx({
    required String token,
    required String deviceId,
  }) async {
    try {
      final data = await api.addDeviceApi(token: token, deviceId: deviceId);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(Map data) {
    dataFetcher.sink.add(data);
    return true;
  }

  // is_nutration
  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 400) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        if (error.response!.statusCode == 401) {
          ToastUtil.showShortToast(error.response!.data["message"]);
          totalDataClean();
          NavigationService.navigateToReplacement(Routes.signInScreen);
        } else {
          ToastUtil.showShortToast(error.response!.data["message"]);
        }
      }
      log(error.toString());
      dataFetcher.sink.addError(error);
      return false;
    }
  }
}
