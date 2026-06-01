import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import '../../../../../helpers/all_routes.dart';
import '../../../../../helpers/navigation_service.dart';
import '../../../../../networks/stream_cleaner.dart';
import 'api.dart';
import 'model/user_info_response.dart';

final class UserInfoRx extends RxResponseInt<UserInfoResponse> {
  final api = UserInfoApi.instance;

  UserInfoRx({required super.empty, required super.dataFetcher});

  ValueStream<UserInfoResponse> get userInfoRxStream => dataFetcher.stream;

  Future<bool> userInfoRx() async {
    try {
      UserInfoResponse data = await api.userInfoApi();
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {

      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(UserInfoResponse data) {
    dataFetcher.sink.add(data);
    return true;
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
