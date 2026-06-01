import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class ChangePasswordApi {
  static final ChangePasswordApi _singleton = ChangePasswordApi._internal();
  ChangePasswordApi._internal();

  static ChangePasswordApi get instance => _singleton;

  Future<Map> changePasswordApi({
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      Map data = {
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
      Response response = await postHttp(Endpoints.passwordUpdate(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(json.encode(response.data));
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
