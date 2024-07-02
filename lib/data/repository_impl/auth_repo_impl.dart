import 'package:dio/dio.dart';
import 'package:flutter_demo_structure/core/api/base_response/base_response.dart';
import 'package:flutter_demo_structure/core/exceptions/dio_exception_util.dart';
import 'package:flutter_demo_structure/data/model/response/otp_model.dart';
import 'package:flutter_demo_structure/data/model/response/social_profile_model.dart';
import 'package:flutter_demo_structure/data/remote/auth_api.dart';
import 'package:flutter_demo_structure/data/repository/auth_repo.dart';

import '../../core/locator/locator.dart';

class AuthRepoImpl extends AuthRepository {
  AuthApi authApi;

  AuthRepoImpl({required this.authApi});

  @override
  Future<BaseResponse<OtpModel>> otp(Map<String, dynamic> data) async {
    try {
      BaseResponse<OtpModel> response = await authApi.otp(data);
      return response;
    } on DioException catch (e) {
      DioExceptionUtil.handleError(e);
      rethrow;
    }
  }

  @override
  Future<BaseResponse<SocialProfileModel>> profileData(
      Map<String, dynamic> data) async {
    try {
      BaseResponse<SocialProfileModel> response =
          await authApi.profileData(data);
      return response;
    } on DioException catch (e) {
      DioExceptionUtil.handleError(e);
      rethrow;
    }
  }

  @override
  Future<BaseResponse> logout() async {
    try {
      BaseResponse response = await authApi.logout();
      return response;
    } on DioException catch (e) {
      DioExceptionUtil.handleError(e);
      rethrow;
    }
  }
}

final authRepo = locator<AuthRepoImpl>();
