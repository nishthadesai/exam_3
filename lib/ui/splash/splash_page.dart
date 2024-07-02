import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/core/locator/locator.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/l10n.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initSetting();
    super.initState();
  }

  Future<void> initSetting() async {
    Future.delayed(const Duration(seconds: 3), () {
      final appDB = locator.get<AppDB>();
      if (!appDB.isLogin) {
        locator<AppRouter>().replaceAll([const LoginRoute()]);
      } else {
        locator<AppRouter>().replaceAll([const HomeRoute()]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColor.green,
      body: buildView(),
      bottomNavigationBar: buildBottomView(),
    );
  }

  Widget buildView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            Assets.imageSplashLogo,
            height: 45.h,
            width: 72.w,
            fit: BoxFit.fill,
          ),
        ),
        15.verticalSpace,
        Text(
          S.of(context).erasustain,
          style: textSemiBold.copyWith(
            fontSize: 24.spMin,
            color: AppColor.white,
          ),
        ),
        30.verticalSpace,
        Text(
          S.of(context).impactingLivesOneNotificationsAtATime,
          maxLines: 2,
          softWrap: false,
          textAlign: TextAlign.center,
          style: textSemiBold.copyWith(
            fontSize: 16.spMin,
            color: AppColor.white,
          ),
        ).wrapPaddingSymmetric(horizontal: 60),
      ],
    );
  }

  Widget buildBottomView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              Assets.imageSplashLion,
              height: 24.h,
              width: 53.w,
              fit: BoxFit.fill,
            ),
            80.horizontalSpace,
            Image.asset(
              Assets.imageSplashStartup,
              height: 24.h,
              width: 96.w,
              fit: BoxFit.fill,
            ),
          ],
        ).wrapPaddingOnly(left: 27, right: 29),
        15.verticalSpace,
        Row(
          children: [
            Text(
              S.of(context).madeInIndia,
              style: textSemiBold.copyWith(
                  fontSize: 16.spMin, color: AppColor.white),
            ),
            10.horizontalSpace,
            Text(
              "|",
              style: textSemiBold.copyWith(
                  fontSize: 16.spMin, color: AppColor.white),
            ),
            10.horizontalSpace,
            Text(
              S.of(context).nayadeshnayisoch,
              style: textSemiBold.copyWith(
                  fontSize: 16.spMin, color: AppColor.white),
            ),
          ],
        ),
        40.verticalSpace,
      ],
    ).wrapPaddingSymmetric(horizontal: 45);
  }
}
