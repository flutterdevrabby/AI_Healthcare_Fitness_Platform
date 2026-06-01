import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class SocialApi {
  static final SocialApi _singleton = SocialApi._internal();
  SocialApi._internal();

  static SocialApi get instance => _singleton;

  Future<Map> socialApi({
    required String token,
    required String provider,
  }) async {
    try {
      Map data = {"token": token, "provider": provider};

      Response response = await postHttp(Endpoints.socialLogin(), data);
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
