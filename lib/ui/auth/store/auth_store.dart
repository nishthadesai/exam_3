import 'package:dio/dio.dart';
import 'package:flutter_demo_structure/core/api/base_response/base_response.dart';
import 'package:flutter_demo_structure/core/locator/locator.dart';
import 'package:flutter_demo_structure/data/repository_impl/auth_repo_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';

import '../../../core/exceptions/app_exceptions.dart';
import '../../../core/exceptions/dio_exception_util.dart';
import '../../../data/model/response/otp_model.dart';
import '../../../data/model/response/social_profile_model.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  BaseResponse<OtpModel>? otpResponse;

  @observable
  BaseResponse? logoutResponse;

  @observable
  BaseResponse<SocialProfileModel>? profileResponse;

  @observable
  String? errorMessage;

  @observable
  bool? isLoading;

  _AuthStoreBase();

  @action
  Future otp(Map<String, dynamic> data) async {
    try {
      errorMessage = null;
      otpResponse =
          await ObservableFuture<BaseResponse<OtpModel>>(authRepo.otp(data));
    } on DioException catch (e) {
      errorMessage = DioExceptionUtil.handleError(e);
    } on AppException catch (e) {
      errorMessage = e.toString();
    }
  }

  @action
  Future profileData(Map<String, dynamic> data) async {
    try {
      isLoading = true;
      errorMessage = null;
      profileResponse =
          await ObservableFuture<BaseResponse<SocialProfileModel>>(
              authRepo.profileData(data));
    } on DioException catch (e) {
      errorMessage = DioExceptionUtil.handleError(e);
    } on AppException catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future logout() async {
    try {
      errorMessage = null;
      logoutResponse = await ObservableFuture<BaseResponse>(authRepo.logout());
    } on DioException catch (e) {
      errorMessage = DioExceptionUtil.handleError(e);
    } on AppException catch (e) {
      errorMessage = e.toString();
    }
  }
}

final authStore = locator<AuthStore>();
final storage = new FlutterSecureStorage();
