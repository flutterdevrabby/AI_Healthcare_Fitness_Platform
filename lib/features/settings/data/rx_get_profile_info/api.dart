import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import 'model/user_info_response.dart';

final class UserInfoApi {
  static final UserInfoApi _singleton = UserInfoApi._internal();
  UserInfoApi._internal();

  static UserInfoApi get instance => _singleton;

  Future<UserInfoResponse> userInfoApi() async {
    try {
      Response response = await getHttp(Endpoints.userInfo());
      if (response.statusCode == 200 || response.statusCode == 201) {
        UserInfoResponse data = UserInfoResponse.fromRawJson(
          json.encode(response.data),
        );
        return data;
      } else {
        // Handle non-200 status code errors
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
