import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class AddDeviceApi {
  static final AddDeviceApi _singleton = AddDeviceApi._internal();
  AddDeviceApi._internal();

  static AddDeviceApi get instance => _singleton;

  Future<Map> addDeviceApi({
    required String token,
    required String deviceId,
  }) async {
    try {
      Map data = {"token": token, "device_id": deviceId};

      Response response = await postHttp(Endpoints.signIn(), data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(json.encode(response.data));

        log(
          "Response================================================================= : $data",
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
