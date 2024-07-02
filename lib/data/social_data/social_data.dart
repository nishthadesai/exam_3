import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/ui/auth/store/auth_store.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class SocialData {
  final Image image;
  final String title;
  final String subTitle;

  SocialData(this.image, this.title, this.subTitle);
}

List socialData = [
  SocialData(Image.asset(Assets.imageCall),
      authStore.profileResponse!.data!.contactNumber, S.current.contactNumber),
  SocialData(Image.asset(Assets.imageEmail),
      authStore.profileResponse!.data!.email, S.current.emailAddress),
  SocialData(Image.asset(Assets.imageWhatsapp),
      authStore.profileResponse!.data!.whatsappNumber, S.current.whatsapp),
  SocialData(Image.asset(Assets.imageLinkedIn),
      authStore.profileResponse!.data!.linkedinUrl, S.current.linkedin),
  SocialData(
      Image.asset(Assets.imageWeb), S.current.wwwwhocom, S.current.website),
  SocialData(Image.asset(Assets.imageMdiInstagram),
      authStore.profileResponse!.data!.instagramUrl, S.current.instagram),
];
