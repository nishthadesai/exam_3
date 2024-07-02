import 'dart:io';

import 'package:apple_product_name/apple_product_name.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_structure/core/api/req_params.dart' as Req;
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/ui/auth/store/auth_store.dart';
import 'package:flutter_demo_structure/values/app_class.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/app_text_filed.dart';
import 'package:flutter_demo_structure/widget/button_widget.dart';
import 'package:flutter_demo_structure/widget/show_message.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../util/app_version.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> isGreen = ValueNotifier(false);
  TextEditingController numberController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void callApiGetOtp() async {
    AppClass().showLoading(true);
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String version = await AppVersion.getVersion();
    var req = Map.of({
      Req.appVersion: version,
      Req.countryCode: "91",
      Req.deviceToken: "0",
      Req.email: "test12@yopmail.com",
      Req.phone: "9924674694",
    });
    if (Platform.isAndroid) {
      var info = await deviceInfo.androidInfo;
      var osVersion = info.version.release;
      var manufacturer = info.manufacturer;
      var modelName = info.model;
      debugPrint(info.device);
      req.addAll({
        Req.deviceType: "A",
        Req.deviceName: info.device,
        Req.modelName: "$manufacturer $modelName",
        Req.osVersion: "Android $osVersion",
      });
    } else if (Platform.isIOS) {
      var info = await deviceInfo.iosInfo;
      debugPrint("Req.deviceName: ${info.name}");
      req.addAll({
        Req.deviceType: "I",
        Req.deviceName: info.name,
        Req.modelName: AppleProductName().lookup(info.utsname.machine),
        Req.osVersion: info.systemVersion,
      });
    }
    await authStore.otp(req).then(
      (value) {
        AppClass().showLoading(false);
        if (authStore.otpResponse?.code == 10) {
          appDB.isLogin = true;
          appDB.token = authStore.otpResponse!.data!.userDetail.token;
          context.router.replaceAll([HomeRoute()]);
          showMessage(S.of(context).loggedinSuccesfully);
        } else {
          showMessage(authStore.errorMessage ?? S.of(context).loginFailed);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: buildView(),
    );
  }

  Widget buildView() {
    return Observer(builder: (context) {
      if (authStore.errorMessage != null) {
        if (authStore.errorMessage == S.current.noActiveInternetConnection) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                Assets.imageNoInternet,
                fit: BoxFit.fill,
                height: 150.h,
              )),
              Text(
                S.of(context).noConnection,
                style: textBold.copyWith(
                    fontSize: 16.spMin, color: AppColor.black),
              ),
              10.verticalSpace,
              Text(
                S.of(context).pleaseCheckYourInternetConnectivityAndTryagain,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: textRegular.copyWith(
                    fontSize: 14.spMin, color: AppColor.black),
              ).wrapPaddingHorizontal(50),
              10.verticalSpace,
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.green),
                  ),
                  onPressed: () {
                    callApiGetOtp();
                  },
                  child: Text(
                    S.of(context).retry,
                    style: textRegular.copyWith(
                        fontSize: 14.spMin, color: AppColor.white),
                  )),
            ],
          );
        } else {
          debugPrint(authStore.errorMessage);
          return SizedBox.shrink();
        }
      } else {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      Assets.imageBackImg,
                      height: 451.r,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 124, left: 10, right: 47).r,
                      child: Text(
                        S.of(context).becomeVolunteerStartDonations,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: textSemiBold.copyWith(
                            fontSize: 24.spMin, color: AppColor.lightBlack),
                      ).wrapPaddingSymmetric(horizontal: 41),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 227).r,
                      child: Image.asset(
                        Assets.imageWoman,
                        height: 260.r,
                        width: 280.r,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                57.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).mobileNo,
                      style: textSemiBold.copyWith(
                        fontSize: 12.spMin,
                        color: AppColor.black.withOpacity(0.30),
                      ),
                    ),
                    10.verticalSpace,
                    AppTextField(
                      onChanged: (val) {
                        if (val?.length == 11) {
                          isGreen.value = true;
                        } else {
                          isGreen.value = false;
                        }
                      },
                      controller: numberController,
                      maxLength: 11,
                      label: '',
                      hint: '00000 00000',
                      filled: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PhoneNumberFormatter(),
                      ],
                      textCapitalization: TextCapitalization.none,
                      keyboardAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      validators: mobileValidator,
                      textStyle: textSemiBold.copyWith(
                          fontSize: 16.spMin, color: AppColor.black),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryCodePicker(
                            textStyle: textSemiBold.copyWith(
                                fontSize: 16.spMin, color: AppColor.black),
                            initialSelection: 'IN',
                            favorite: const ['+91', 'IN'],
                            showFlag: false,
                            padding: EdgeInsets.zero,
                          ),
                          Container(
                            width: 1.5.r,
                            height: 16.r,
                            color: AppColor.black,
                          ).wrapPaddingRight(10),
                        ],
                      ),
                    ),
                    48.verticalSpace,
                    Text(
                      S
                          .of(context)
                          .byContinuingYouAreAgreeingToOutTermsConditionsPrivacy,
                      maxLines: 2,
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: textRegular.copyWith(
                        color: AppColor.black.withOpacity(0.30),
                        fontSize: 12.spMin,
                      ),
                    ).wrapPaddingSymmetric(horizontal: 20),
                    15.verticalSpace,
                    ValueListenableBuilder(
                      valueListenable: isGreen,
                      builder: (context, value, child) {
                        return AppButton(
                          radius: 15.r,
                          buttonColor: isGreen.value == true
                              ? AppColor.green
                              : AppColor.lightGrey,
                          Text(
                            S.of(context).sendOtp,
                            style: textBold.copyWith(
                                fontSize: 16.spMin, color: AppColor.white),
                          ),
                          () {
                            if (formKey.currentState!.validate()) {
                              callApiGetOtp();
                            }
                          },
                        );
                      },
                    ),
                    30.verticalSpace,
                  ],
                ).wrapPaddingSymmetric(horizontal: 30),
              ],
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    isGreen.dispose();
    numberController.dispose();
    super.dispose();
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(' ', '');
    if (newText.length > 5) {
      newText = newText.substring(0, 5) + ' ' + newText.substring(5);
    }
    return TextEditingValue(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
