import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/core/api/req_params.dart' as Req;
import 'package:flutter_demo_structure/core/db/app_db.dart';
import 'package:flutter_demo_structure/data/social_data/social_data.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/router/app_router.dart';
import 'package:flutter_demo_structure/values/export.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_demo_structure/widget/base_app_bar.dart';
import 'package:flutter_demo_structure/widget/button_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/ambassadors_data/ambassadors_data.dart';
import '../../data/model/response/social_profile_model.dart';
import '../../generated/l10n.dart';
import '../../values/app_class.dart';
import '../../widget/show_message.dart';
import '../auth/store/auth_store.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ReactionDisposer>? _disposer;
  SocialProfileModel? profileData;
  @override
  void initState() {
    callApiGetProfileData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    addDisposer();
    super.didChangeDependencies();
  }

  void addDisposer() {
    _disposer = [
      reaction((_) => authStore.profileResponse, (response) {
        // profileData = response?.data;
      }),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    removeDisposer();
  }

  void removeDisposer() {
    for (var element in _disposer!) {
      element.reaction.dispose();
    }
  }

  callApiGetProfileData() async {
    var req = Map.of({Req.socialProfileId: "214"});
    await authStore.profileData(req).then(
      (value) {
        if (authStore.profileResponse?.code == "1") {
        } else {
          showMessage(authStore.errorMessage ?? "");
        }
      },
    );
  }

  callApiLogOut() async {
    AppClass().showLoading(true);
    await authStore.logout().then(
      (value) {
        AppClass().showLoading(false);
        if (authStore.logoutResponse?.code == "1") {
          appDB.logout();
          context.router.replaceAll([LoginRoute()]);
          showMessage(S.of(context).logoutSuccessfully);
        } else {
          context.router.maybePop();
          showMessage(authStore.errorMessage ?? S.of(context).logoutFailed);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Observer(builder: (context) {
          if (authStore.errorMessage != null) {
            return SizedBox.shrink();
          } else {
            return buildAppBar();
          }
        }),
      ),
      body: buildView(),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return BaseAppBar(
      backgroundColor: AppColor.white,
      centerTitle: false,
      showTitle: true,
      titleWidget: Text(
        S.of(context).socialPartner,
        style: textMedium.copyWith(fontSize: 24.spMin, color: AppColor.green),
      ).wrapPaddingLeft(15),
      action: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    S.of(context).logout,
                    style: textSemiBold.copyWith(fontSize: 16.spMin),
                  ),
                  content: Text(
                    S.of(context).areYouSureYouWantToLogout,
                    style: textRegular.copyWith(fontSize: 16.spMin),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.router.maybePop();
                          },
                          child: Text(S.of(context).cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            if (authStore.errorMessage == null) {
                              callApiLogOut();
                            } else {
                              showMessage(authStore.logoutResponse?.message ??
                                  S.of(context).logoutFailed);
                            }
                          },
                          child: Text(S.of(context).ok),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset(
            Assets.imagePower,
            height: 32.r,
            width: 30.r,
          ).wrapPaddingOnly(left: 15, right: 10),
        ),
        Observer(builder: (context) {
          if (authStore.profileResponse != null) {
            return CircleAvatar(
              backgroundColor: AppColor.transparent,
              backgroundImage: NetworkImage(profileData?.profileImage ??
                  "https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcR0NrOJEpfjkM0zxD-aO9b-bWqW3mhY57jPMg3aSbxTYO__R4jOvx8T2Oa7Fm9yxXOGg4B_ns3SZaZGCiBOPQw"),
              radius: 16.r,
            ).wrapPaddingRight(30);
          } else {
            return Shimmer.fromColors(
                child: CircleAvatar(
                  backgroundColor: AppColor.grey,
                  radius: 16.r,
                ).wrapPaddingRight(30),
                baseColor: AppColor.white,
                highlightColor: AppColor.transparent);
          }
        }),
      ],
    );
  }

  Widget buildView() {
    return Observer(builder: (context) {
      if (authStore.isLoading == true) {
        return Center(child: CircularProgressIndicator());
      } else if (authStore.errorMessage != null) {
        if (authStore.errorMessage ==
            S.of(context).noActiveInternetConnection) {
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
                    callApiGetProfileData();
                  },
                  child: Text(
                    S.of(context).retry,
                    style: textRegular.copyWith(
                        fontSize: 14.spMin, color: AppColor.white),
                  )),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      } else {
        return profileData != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildDetailsView(),
                    buildBottomListView(),
                  ],
                ),
              )
            : Center(child: Text("Data not found"));
      }
    });
  }

  Widget buildBottomListView() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.lightYellow,
          borderRadius: BorderRadius.circular(30).r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileData!.normalCampaignData.campaignType.toTitleCase(),
                style: textSemiBold.copyWith(
                    fontSize: 12.spMin, color: AppColor.lightBrown),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: AppColor.lightWhite,
                    borderRadius: BorderRadius.circular(15).r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        profileData!
                            .normalCampaignData.campaignMediaList[0].postImage,
                        height: 174.r,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(10).r,
                    ),
                    15.5.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                profileData!.normalCampaignData.campaignName,
                                maxLines: 1,
                                softWrap: false,
                                style: textSemiBold.copyWith(
                                    fontSize: 14.spMin, color: AppColor.black),
                              ).wrapPaddingRight(10),
                              5.verticalSpace,
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${DateFormat('MMM dd, yy').format(profileData!.normalCampaignData.startDate)}, ${profileData!.normalCampaignData.country}',
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color:
                                              AppColor.black.withOpacity(0.50)),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Text("|",
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color: AppColor.black
                                              .withOpacity(0.50))),
                                  10.horizontalSpace,
                                  Flexible(
                                    child: Text(
                                      "${profileData!.normalCampaignData.intrested} interested",
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color:
                                              AppColor.black.withOpacity(0.50)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).wrapPaddingRight(15),
                        ),
                        InkWell(
                          onTap: () async {
                            await Share.share(S.of(context).socialPartnerApp,
                                subject: S.of(context).mailToMe);
                          },
                          child: Row(
                            children: [
                              Text(
                                S.of(context).share,
                                style: textSemiBold.copyWith(
                                    fontSize: 12.spMin, color: AppColor.green),
                              ),
                              5.horizontalSpace,
                              Image.asset(
                                Assets.imageShare,
                                height: 12.r,
                                width: 10.r,
                              ),
                            ],
                          ).wrapPaddingSymmetric(horizontal: 10, vertical: 12),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15).r,
                              color: AppColor.lightBrown.withOpacity(0.10),
                            ),
                            child: Text(
                              'End Date ; ${DateFormat('dd MMM yy').format(profileData!.normalCampaignData.endDate)}',
                              maxLines: 1,
                              softWrap: false,
                              style: textSemiBold.copyWith(
                                  fontSize: 12.spMin,
                                  color: AppColor.lightBrown),
                            ).wrapPaddingSymmetric(vertical: 5, horizontal: 7),
                          ),
                        ),
                        5.horizontalSpace,
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15).r,
                              color: AppColor.lightBrown.withOpacity(0.10),
                            ),
                            child: Text(
                              "${profileData!.normalCampaignData.participated} Participated"
                                  .toLowerCase(),
                              maxLines: 1,
                              softWrap: false,
                              style: textSemiBold.copyWith(
                                  fontSize: 12.spMin,
                                  color: AppColor.lightBrown),
                            ).wrapPaddingSymmetric(vertical: 5, horizontal: 7),
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Flexible(
                      child: Text(
                        profileData!.normalCampaignData.discription,
                        maxLines: 3,
                        softWrap: false,
                        style: textRegular.copyWith(
                            fontSize: 12.spMin,
                            color: AppColor.black.withOpacity(0.70)),
                      ),
                    ),
                    15.verticalSpace,
                    SizedBox(
                      height: 38.r,
                      width: 94,
                      child: AppButton(
                        elevation: 0,
                        radius: 15.r,
                        buttonColor: AppColor.green,
                        Text(
                          S.of(context).donate,
                          style: textBold.copyWith(
                              fontSize: 12.spMin, color: AppColor.white),
                        ),
                        () {},
                      ),
                    ),
                    15.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        color: AppColor.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$${profileData?.raisedAmount} ",
                                    style: textBold.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.green),
                                  ),
                                  Text(
                                    S.of(context).raised,
                                    style: textRegular.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.green),
                                  ),
                                  Text(
                                    "  (\$${profileData?.normalCampaignData.needAmountRaised} goal)",
                                    style: textRegular.copyWith(
                                        fontSize: 12.spMin,
                                        color:
                                            AppColor.black.withOpacity(0.50)),
                                  ),
                                ],
                              ),
                              Text(
                                "0%",
                                style: textRegular.copyWith(
                                    fontSize: 12.spMin,
                                    color: AppColor.black.withOpacity(0.50)),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            alignment: MainAxisAlignment.start,
                            lineHeight: 9.h,
                            animation: false,
                            barRadius: Radius.circular(15).r,
                            width: 255.w,
                            // lineHeight: 9.h,
                            percent: 0,
                            backgroundColor: AppColor.green.withOpacity(0.10),
                            progressColor: AppColor.green,
                          ),
                        ],
                      ).wrapPaddingSymmetric(vertical: 10, horizontal: 15),
                    ),
                  ],
                ).wrapPaddingAll(15),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  color: AppColor.green.withOpacity(0.15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View All ${profileData!.normalCampaignData.campaignType.toTitleCase()}",
                      style: textBold.copyWith(
                          fontSize: 12.spMin, color: AppColor.green),
                    ),
                    10.horizontalSpace,
                    Image.asset(
                      Assets.imageArrowRight,
                      height: 11.r,
                      width: 16.r,
                      color: AppColor.green,
                    ),
                  ],
                ).wrapPaddingVertical(11.5),
              ),
              30.verticalSpace,
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileData!.sosCampaignData.campaignType.toTitleCase(),
                style: textSemiBold.copyWith(
                    fontSize: 12.spMin, color: AppColor.lightBrown),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: AppColor.lightWhite,
                    borderRadius: BorderRadius.circular(15).r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10).r,
                      child: Image.network(
                        profileData!
                            .sosCampaignData.campaignMediaList[0].postImage,
                        height: 174.r,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    15.5.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                profileData!.sosCampaignData.campaignName,
                                maxLines: 1,
                                softWrap: false,
                                style: textSemiBold.copyWith(
                                    fontSize: 14.spMin, color: AppColor.black),
                              ).wrapPaddingRight(10),
                              5.verticalSpace,
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${DateFormat('MMM dd, yy').format(profileData!.sosCampaignData.startDate)}, ${profileData!.sosCampaignData.country}',
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color:
                                              AppColor.black.withOpacity(0.50)),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Text("|",
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color: AppColor.black
                                              .withOpacity(0.50))),
                                  10.horizontalSpace,
                                  Flexible(
                                    child: Text(
                                      "${profileData!.sosCampaignData.intrested} interested",
                                      maxLines: 1,
                                      softWrap: false,
                                      style: textRegular.copyWith(
                                          fontSize: 12.spMin,
                                          color:
                                              AppColor.black.withOpacity(0.50)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).wrapPaddingRight(15),
                        ),
                        InkWell(
                          onTap: () async {
                            await Share.share(S.of(context).socialPartnerApp,
                                // 'build/app/outputs/flutter-apk/app-release.apk',
                                subject: 'Mail to me');
                          },
                          child: Row(
                            children: [
                              Text(
                                S.of(context).share,
                                style: textSemiBold.copyWith(
                                    fontSize: 12.spMin, color: AppColor.green),
                              ),
                              5.horizontalSpace,
                              Image.asset(
                                Assets.imageShare,
                                height: 12.r,
                                width: 10.r,
                              ),
                            ],
                          ).wrapPaddingSymmetric(horizontal: 10, vertical: 12),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15).r,
                              color: AppColor.lightBrown.withOpacity(0.10),
                            ),
                            child: Text(
                              profileData!.sosCampaignData.daysLeft,
                              maxLines: 1,
                              softWrap: false,
                              style: textSemiBold.copyWith(
                                  fontSize: 12.spMin,
                                  color: AppColor.lightBrown),
                            ).wrapPaddingSymmetric(vertical: 5, horizontal: 7),
                          ),
                        ),
                        5.horizontalSpace,
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15).r,
                              color: AppColor.lightBrown.withOpacity(0.10),
                            ),
                            child: Text(
                              "${profileData!.sosCampaignData.participated} Participated"
                                  .toLowerCase(),
                              maxLines: 1,
                              softWrap: false,
                              style: textSemiBold.copyWith(
                                  fontSize: 12.spMin,
                                  color: AppColor.lightBrown),
                            ).wrapPaddingSymmetric(vertical: 5, horizontal: 7),
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Flexible(
                      child: Text(
                        profileData!.sosCampaignData.discription,
                        maxLines: 3,
                        softWrap: false,
                        style: textRegular.copyWith(
                            fontSize: 12.spMin,
                            color: AppColor.black.withOpacity(0.70)),
                      ),
                    ),
                    15.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10).r,
                        color: AppColor.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$${profileData?.raisedAmount} ",
                                    style: textBold.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.green),
                                  ),
                                  Text(
                                    S.of(context).raised,
                                    style: textRegular.copyWith(
                                        fontSize: 12.spMin,
                                        color: AppColor.green),
                                  ),
                                  Text(
                                    "  (\$${profileData?.sosCampaignData.needAmountRaised} goal)",
                                    style: textRegular.copyWith(
                                        fontSize: 12.spMin,
                                        color:
                                            AppColor.black.withOpacity(0.50)),
                                  ),
                                ],
                              ),
                              Text(
                                "0%",
                                style: textRegular.copyWith(
                                    fontSize: 12.spMin,
                                    color: AppColor.black.withOpacity(0.50)),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            alignment: MainAxisAlignment.start,
                            lineHeight: 9.h,
                            animation: false,
                            barRadius: Radius.circular(15).r,
                            width: 255.w,
                            // lineHeight: 9.h,
                            percent: 0,
                            backgroundColor: AppColor.green.withOpacity(0.10),
                            progressColor: AppColor.green,
                          ),
                        ],
                      ).wrapPaddingSymmetric(vertical: 10, horizontal: 15),
                    ),
                  ],
                ).wrapPaddingAll(15),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  color: AppColor.green.withOpacity(0.15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View All ${profileData!.sosCampaignData.campaignType.toTitleCase()}",
                      style: textBold.copyWith(
                          fontSize: 12.spMin, color: AppColor.green),
                    ),
                    10.horizontalSpace,
                    Image.asset(
                      Assets.imageArrowRight,
                      height: 11.r,
                      width: 16.r,
                      color: AppColor.green,
                    ),
                  ],
                ).wrapPaddingVertical(11.5),
              ),
              30.verticalSpace,
            ],
          )
        ],
      ).wrapPaddingSymmetric(horizontal: 30, vertical: 15),
    );
  }

  Widget buildDetailsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        35.verticalSpace,
        CachedNetworkImage(
          imageUrl: profileData!.coverImage,
          height: 192.r,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        30.verticalSpace,
        buildWHO(),
        30.verticalSpace,
        buildAboutUs(),
        30.verticalSpace,
        buildCommitFollowButton(),
        30.verticalSpace,
        buildContactView(),
        30.verticalSpace,
        buildCertifyVolunteer(),
        30.verticalSpace,
        buildCelibrityList(),
        30.verticalSpace,
        buildCompanyList(),
        30.verticalSpace,
        buildVolunteerView(),
        30.verticalSpace,
      ],
    ).wrapPaddingSymmetric(horizontal: 30);
  }

  Widget buildWHO() {
    return Row(
      children: [
        Image.asset(
          Assets.imageWhoLogo,
          height: 60.r,
          width: 60.r,
          fit: BoxFit.fill,
        ),
        15.horizontalSpace,
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      S.of(context).worldHealthOrganisation,
                      style: textSemiBold.copyWith(
                          fontSize: 16.spMin, color: AppColor.black),
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                  8.horizontalSpace,
                  Image.asset(
                    Assets.imageVerify,
                    height: 18.r,
                    width: 18.r,
                  ),
                ],
              ),
              13.verticalSpace,
              Container(
                decoration: BoxDecoration(
                    color: AppColor.lightWhite,
                    borderRadius: BorderRadius.circular(15).r),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "12 ",
                      style: textBold.copyWith(
                          fontSize: 12.spMin,
                          color: AppColor.black.withOpacity(0.40)),
                    ),
                    Flexible(
                      child: Text(
                        S.of(context).mutualsIncludingKaran,
                        maxLines: 1,
                        softWrap: false,
                        style: textSemiBold.copyWith(
                            fontSize: 12.spMin,
                            color: AppColor.black.withOpacity(0.40)),
                      ),
                    ),
                  ],
                ).wrapPaddingSymmetric(horizontal: 7, vertical: 5),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildAboutUs() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).aboutUs,
          style: textBold.copyWith(fontSize: 14.spMin, color: AppColor.black),
          maxLines: 2,
          softWrap: false,
        ),
        5.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" •  "),
            Flexible(
              child: Text(
                S.of(context).weAreAMultinationalNpoWorkingTowardsTheWelfareOf,
                maxLines: 2,
                softWrap: false,
                style: textRegular.copyWith(
                    fontSize: 12.spMin,
                    color: AppColor.black.withOpacity(0.70)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCommitFollowButton() {
    return Row(
      children: [
        SizedBox(
          height: 38.r,
          width: 160.r,
          child: AppButton(
            elevation: 0,
            radius: 15.r,
            buttonColor: AppColor.green,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).committed,
                  style: textBold.copyWith(
                      fontSize: 12.spMin, color: AppColor.white),
                ),
                9.horizontalSpace,
                Image.asset(
                  Assets.imageDoneWhite,
                  height: 9.r,
                  width: 11.r,
                ),
              ],
            ),
            () {},
          ),
        ),
        15.horizontalSpace,
        SizedBox(
          height: 38.r,
          width: 140.r,
          child: AppButton(
            elevation: 0,
            radius: 15.r,
            buttonColor: AppColor.green.withOpacity(0.15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.of(context).followed,
                  style: textBold.copyWith(
                      fontSize: 12.spMin, color: AppColor.green),
                ),
                9.horizontalSpace,
                Flexible(
                  child: Image.asset(
                    Assets.imagePersonDone,
                    height: 14.r,
                    width: 14.r,
                  ),
                ),
              ],
            ),
            () {},
          ),
        ),
      ],
    );
  }

  Widget buildContactView() {
    return Row(
      children: [
        Container(
          width: 102.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: AppColor.lightWhite,
          ),
          child: Column(
            children: [
              Text(
                profileData!.totalCommitted.toString(),
                style: textSemiBold.copyWith(
                    fontSize: 14.spMin, color: AppColor.black),
              ),
              5.verticalSpace,
              Text(
                S.of(context).committed.toLowerCase(),
                style: textRegular.copyWith(
                    fontSize: 12.spMin,
                    color: AppColor.black.withOpacity(0.50)),
              ),
            ],
          ).wrapPaddingVertical(6),
        ),
        10.horizontalSpace,
        Container(
          width: 93.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).r,
            color: AppColor.lightWhite,
          ),
          child: Column(
            children: [
              Text(
                profileData!.totalFollowers.toString(),
                style: textSemiBold.copyWith(
                    fontSize: 14.spMin, color: AppColor.black),
              ),
              5.verticalSpace,
              Text(
                "followers",
                style: textRegular.copyWith(
                    fontSize: 12.spMin,
                    color: AppColor.black.withOpacity(0.50)),
              ),
            ],
          ).wrapPaddingVertical(6),
        ),
        10.horizontalSpace,
        InkWell(
          onTap: () {
            showModalBottomSheet(
              backgroundColor: AppColor.transparent,
              isDismissible: true,
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50).r,
                        topRight: Radius.circular(50).r),
                    color: AppColor.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        10.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                              color: AppColor.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10).r),
                          height: 5.r,
                          width: 40.r,
                        ),
                        45.verticalSpace,
                        Flexible(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              SocialData data = socialData[index];
                              return Row(
                                children: [
                                  Container(
                                    height: 50.r,
                                    width: 50.r,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10).r,
                                      color: AppColor.lightWhite,
                                    ),
                                    child: data.image.wrapPaddingAll(13),
                                  ),
                                  15.horizontalSpace,
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.title,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: textSemiBold.copyWith(
                                              fontSize: 14.spMin,
                                              color: AppColor.black),
                                        ),
                                        5.verticalSpace,
                                        Text(
                                          data.subTitle,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: textRegular.copyWith(
                                              fontSize: 12.spMin,
                                              color: AppColor.black
                                                  .withOpacity(0.50)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ).wrapPaddingBottom(30);
                            },
                          ).wrapPaddingHorizontal(30),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 100.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              color: AppColor.green.withOpacity(0.15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.imageCall,
                      height: 12.r,
                      width: 12.r,
                    ),
                    5.horizontalSpace,
                    Image.asset(
                      Assets.imageEmail,
                      height: 12.r,
                      width: 14.r,
                    ),
                    5.horizontalSpace,
                    Image.asset(
                      Assets.imageWhatsapp,
                      height: 15.r,
                      width: 15.r,
                    ),
                  ],
                ).wrapPaddingSymmetric(horizontal: 20),
                3.verticalSpace,
                Text(
                  S.of(context).contact,
                  style: textRegular.copyWith(
                      fontSize: 12.spMin, color: AppColor.green),
                ),
              ],
            ).wrapPaddingVertical(6),
          ),
        ),
      ],
    );
  }

  Widget buildCertifyVolunteer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 38.r,
          decoration: BoxDecoration(
              color: AppColor.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15).r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  S.of(context).getCertificate,
                  style: textBold.copyWith(
                      fontSize: 12.spMin, color: AppColor.green),
                ),
                10.horizontalSpace,
                Image.asset(
                  Assets.imageDone,
                  height: 24.r,
                  width: 24.r,
                ),
              ],
            ),
          ),
        ),
        30.verticalSpace,
        Container(
          width: double.infinity,
          height: 38.r,
          decoration: BoxDecoration(
              color: AppColor.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15).r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.of(context).volunteer,
                style: textBold.copyWith(
                    fontSize: 12.spMin, color: AppColor.green),
              ),
              10.horizontalSpace,
              Image.asset(
                Assets.imagePersonGo,
                height: 16.r,
                width: 16.r,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCelibrityList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        color: AppColor.lightWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          Text(
            S.of(context).celebrityAmbassadors,
            style: textRegular.copyWith(
                fontSize: 12.spMin, color: AppColor.black.withOpacity(0.50)),
          ).wrapPaddingLeft(15),
          15.verticalSpace,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                profileData!.celebrity.length,
                (index) {
                  var celebrityData = profileData!.celebrity[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(celebrityData.profileImage),
                        radius: 28.r,
                      ),
                      15.verticalSpace,
                      Container(
                        width: 57,
                        child: Text(
                          celebrityData.name,
                          textAlign: TextAlign.center,
                          style: textRegular.copyWith(
                              fontSize: 12.spMin,
                              color: AppColor.black.withOpacity(0.50)),
                          maxLines: 2,
                          softWrap: false,
                        ).wrapPaddingBottom(10),
                      ),
                    ],
                  ).wrapPaddingOnly(right: 30, left: index == 0 ? 15 : 0);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompanyList() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        color: AppColor.lightWhite,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.verticalSpace,
          Text(
            S.of(context).companyAmbassadors,
            style: textRegular.copyWith(
                fontSize: 12.spMin, color: AppColor.black.withOpacity(0.50)),
          ).wrapPaddingLeft(15),
          15.verticalSpace,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                ambassadorsData.length,
                (index) {
                  AmbassadorsData data = ambassadorsData[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 56.r, width: 56.r, child: data.image),
                      15.verticalSpace,
                      Container(
                        width: 57,
                        child: Text(
                          data.title,
                          style: textRegular.copyWith(
                              fontSize: 12.spMin,
                              color: AppColor.black.withOpacity(0.50)),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          softWrap: false,
                        ).wrapPaddingBottom(10),
                      )
                    ],
                  ).wrapPaddingOnly(right: 30, left: index == 0 ? 15 : 0);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVolunteerView() {
    return Container(
      height: 47.r,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.lightWhite,
          borderRadius: BorderRadius.circular(10).r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              S.of(context).topVolunteer,
              maxLines: 1,
              softWrap: false,
              style: textRegular.copyWith(
                  fontSize: 12.spMin, color: AppColor.black.withOpacity(0.50)),
            ),
          ),
          Flexible(
            child: Text(
              profileData?.topVolunteer ?? S.of(context).karanChawla,
              style: textSemiBold.copyWith(
                  fontSize: 14.spMin, color: AppColor.black),
              maxLines: 1,
              softWrap: false,
            ).wrapPaddingLeft(20),
          )
        ],
      ).wrapPaddingAll(12),
    );
  }
}
