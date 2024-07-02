import 'package:flutter_demo_structure/core/api/base_response/base_response.dart';

import '../model/response/otp_model.dart';
import '../model/response/social_profile_model.dart';

abstract class AuthRepository {
  Future<BaseResponse<OtpModel>> otp(Map<String, dynamic> data);
  Future<BaseResponse<SocialProfileModel>> profileData(
      Map<String, dynamic> data);
  Future<BaseResponse> logout();
}
