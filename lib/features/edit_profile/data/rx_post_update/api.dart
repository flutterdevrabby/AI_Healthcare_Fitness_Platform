import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class UpdateProfileApi {
  static final UpdateProfileApi _singleton = UpdateProfileApi._internal();
  UpdateProfileApi._internal();

  static UpdateProfileApi get instance => _singleton;

  Future<Map> updateProfileApi({
    String? name,
    int? age,
    int? weight,
    int? height,
    int? targetWeight,
    File? avatar,
  }) async {
    try {
      /// FormData instead of Map
      FormData formData = FormData.fromMap({
        "name": name,
        "age": age,
        "current_weight": weight,
        "height": height,
        "target_weight": targetWeight,
      });

      /// Attach image if exists
      if (avatar != null) {
        formData.files.add(
          MapEntry(
            "avatar",
            await MultipartFile.fromFile(
              avatar.path,
              filename: avatar.path.split('/').last,
            ),
          ),
        );
      }

      Response response = await postHttp(Endpoints.updateProfile(), formData);
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
