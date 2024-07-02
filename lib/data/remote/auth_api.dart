import 'package:dio/dio.dart';
import 'package:flutter_demo_structure/core/api/base_response/base_response.dart';
import 'package:flutter_demo_structure/data/model/response/otp_model.dart';
import 'package:retrofit/retrofit.dart';

import '../model/response/social_profile_model.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  // @POST('/user_authentication/logout')
  // Future<BaseResponse> logout();

  @POST('general/send_otp')
  Future<BaseResponse<OtpModel>> otp(@Body() Map<String, dynamic> data);

  @POST('user/get_social_profile')
  Future<BaseResponse<SocialProfileModel>> profileData(
      @Body() Map<String, dynamic> data);

  @POST('user/logout')
  Future<BaseResponse> logout();
}
