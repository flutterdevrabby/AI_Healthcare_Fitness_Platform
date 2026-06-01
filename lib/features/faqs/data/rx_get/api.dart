import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';
import '../model/faq_repsonse.dart';

final class FaqsApi {
  static final FaqsApi _singleton = FaqsApi._internal();
  FaqsApi._internal();

  static FaqsApi get instance => _singleton;

  Future<FaqResponse> faqsApi() async {
    try {
      Response response = await getHttp(Endpoints.faq());
      if (response.statusCode == 200 || response.statusCode == 201) {
        FaqResponse data = FaqResponse.fromRawJson(json.encode(response.data));
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
