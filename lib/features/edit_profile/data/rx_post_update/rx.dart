import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';

final class UpdateProfileRx extends RxResponseInt<Map> {
  final api = UpdateProfileApi.instance;

  UpdateProfileRx({required super.empty, required super.dataFetcher});

  ValueStream<Map> get userInfoRxStream => dataFetcher.stream;

  Future<bool> userInfoRx({
    String? name,
    int? age,
    int? weight,
    int? height,
    int? targetWeight,
    File? avatar,
  }) async {
    try {
      final data = await api.updateProfileApi(
        age: age,
        avatar: avatar,
        height: height,
        weight: weight,
        name: name,
        targetWeight: targetWeight,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

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
