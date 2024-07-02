// To parse this JSON data, do
//
//     final socialProfileModel = socialProfileModelFromJson(jsonString);

import 'dart:convert';

SocialProfileModel socialProfileModelFromJson(String str) =>
    SocialProfileModel.fromJson(json.decode(str));

String socialProfileModelToJson(SocialProfileModel data) =>
    json.encode(data.toJson());

class SocialProfileModel {
  int id;
  int userId;
  String name;
  String email;
  String contactNumber;
  String whatsappNumber;
  String instagramUrl;
  String linkedinUrl;
  String url;
  String description;
  String category;
  String location;
  String noOfPush;
  String bankName;
  String accountNumber;
  String accountHolderName;
  String ifscCode;
  String panNo;
  String profileImage;
  String coverImage;
  String idImage;
  dynamic companyIds;
  dynamic celebrityIds;
  String status;
  String isVerify;
  DateTime insertdate;
  DateTime updatetime;
  String volunteerRequest;
  String fcraDoc;
  int totalRating;
  String acCertificate;
  String csrCertificate;
  String facebookUrl;
  String twitterUrl;
  String spentAmount;
  String budget;
  String fcraVerifyFlag;
  String csrVerifyFlag;
  String city;
  dynamic state;
  dynamic country;
  int volunteerCertificateDuration;
  String urnNumber;
  String fcraNumber;
  String panNumber;
  String categoryName;
  int raisedAmount;
  String socialIdImage;
  int userRating;
  bool csrRequestFlag;
  bool socialFollow;
  bool socialCommit;
  int totalFollowers;
  int totalCommitted;
  List<Celebrity> celebrity;
  dynamic agency;
  dynamic company;
  dynamic topVolunteer;
  List<TieUpDatum> tieUpData;
  dynamic tieUpByCsrData;
  dynamic topDonor;
  NormalCampaignData normalCampaignData;
  SosCampaignData sosCampaignData;
  dynamic socialCsrCampaign;
  dynamic mutualFriend;
  bool volunteerFlag;

  SocialProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.instagramUrl,
    required this.linkedinUrl,
    required this.url,
    required this.description,
    required this.category,
    required this.location,
    required this.noOfPush,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolderName,
    required this.ifscCode,
    required this.panNo,
    required this.profileImage,
    required this.coverImage,
    required this.idImage,
    required this.companyIds,
    required this.celebrityIds,
    required this.status,
    required this.isVerify,
    required this.insertdate,
    required this.updatetime,
    required this.volunteerRequest,
    required this.fcraDoc,
    required this.totalRating,
    required this.acCertificate,
    required this.csrCertificate,
    required this.facebookUrl,
    required this.twitterUrl,
    required this.spentAmount,
    required this.budget,
    required this.fcraVerifyFlag,
    required this.csrVerifyFlag,
    required this.city,
    required this.state,
    required this.country,
    required this.volunteerCertificateDuration,
    required this.urnNumber,
    required this.fcraNumber,
    required this.panNumber,
    required this.categoryName,
    required this.raisedAmount,
    required this.socialIdImage,
    required this.userRating,
    required this.csrRequestFlag,
    required this.socialFollow,
    required this.socialCommit,
    required this.totalFollowers,
    required this.totalCommitted,
    required this.celebrity,
    required this.agency,
    required this.company,
    required this.topVolunteer,
    required this.tieUpData,
    required this.tieUpByCsrData,
    required this.topDonor,
    required this.normalCampaignData,
    required this.sosCampaignData,
    required this.socialCsrCampaign,
    required this.mutualFriend,
    required this.volunteerFlag,
  });

  factory SocialProfileModel.fromJson(Map<String, dynamic> json) =>
      SocialProfileModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        contactNumber: json["contact_number"],
        whatsappNumber: json["whatsapp_number"],
        instagramUrl: json["instagram_url"],
        linkedinUrl: json["linkedin_url"],
        url: json["url"],
        description: json["description"],
        category: json["category"],
        location: json["location"],
        noOfPush: json["no_of_push"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        accountHolderName: json["account_holder_name"],
        ifscCode: json["IFSC_code"],
        panNo: json["pan_no"],
        profileImage: json["profile_image"],
        coverImage: json["cover_image"],
        idImage: json["id_image"],
        companyIds: json["company_ids"],
        celebrityIds: json["celebrity_ids"],
        status: json["status"],
        isVerify: json["is_verify"],
        insertdate: DateTime.parse(json["insertdate"]),
        updatetime: DateTime.parse(json["updatetime"]),
        volunteerRequest: json["volunteer_request"],
        fcraDoc: json["fcra_doc"],
        totalRating: json["total_rating"],
        acCertificate: json["ac_certificate"],
        csrCertificate: json["csr_certificate"],
        facebookUrl: json["facebook_url"],
        twitterUrl: json["twitter_url"],
        spentAmount: json["spent_amount"],
        budget: json["budget"],
        fcraVerifyFlag: json["fcra_verify_flag"],
        csrVerifyFlag: json["csr_verify_flag"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        volunteerCertificateDuration: json["volunteer_certificate_duration"],
        urnNumber: json["urn_number"],
        fcraNumber: json["fcra_number"],
        panNumber: json["pan_number"],
        categoryName: json["category_name"],
        raisedAmount: json["raised_amount"],
        socialIdImage: json["social_id_image"],
        userRating: json["user_rating"],
        csrRequestFlag: json["csr_request_flag"],
        socialFollow: json["social_follow"],
        socialCommit: json["social_commit"],
        totalFollowers: json["total_followers"],
        totalCommitted: json["total_committed"],
        celebrity: List<Celebrity>.from(
            json["celebrity"].map((x) => Celebrity.fromJson(x))),
        agency: json["agency"],
        company: json["company"],
        topVolunteer: json["top_volunteer"],
        tieUpData: List<TieUpDatum>.from(
            json["tie_up_data"].map((x) => TieUpDatum.fromJson(x))),
        tieUpByCsrData: json["tie_up_by_csr_data"],
        topDonor: json["top_donor"],
        normalCampaignData:
            NormalCampaignData.fromJson(json["normal_campaign_data"]),
        sosCampaignData: SosCampaignData.fromJson(json["sos_campaign_data"]),
        socialCsrCampaign: json["social_csr_campaign"],
        mutualFriend: json["mutual_friend"],
        volunteerFlag: json["volunteer_flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "contact_number": contactNumber,
        "whatsapp_number": whatsappNumber,
        "instagram_url": instagramUrl,
        "linkedin_url": linkedinUrl,
        "url": url,
        "description": description,
        "category": category,
        "location": location,
        "no_of_push": noOfPush,
        "bank_name": bankName,
        "account_number": accountNumber,
        "account_holder_name": accountHolderName,
        "IFSC_code": ifscCode,
        "pan_no": panNo,
        "profile_image": profileImage,
        "cover_image": coverImage,
        "id_image": idImage,
        "company_ids": companyIds,
        "celebrity_ids": celebrityIds,
        "status": status,
        "is_verify": isVerify,
        "insertdate": insertdate.toIso8601String(),
        "updatetime": updatetime.toIso8601String(),
        "volunteer_request": volunteerRequest,
        "fcra_doc": fcraDoc,
        "total_rating": totalRating,
        "ac_certificate": acCertificate,
        "csr_certificate": csrCertificate,
        "facebook_url": facebookUrl,
        "twitter_url": twitterUrl,
        "spent_amount": spentAmount,
        "budget": budget,
        "fcra_verify_flag": fcraVerifyFlag,
        "csr_verify_flag": csrVerifyFlag,
        "city": city,
        "state": state,
        "country": country,
        "volunteer_certificate_duration": volunteerCertificateDuration,
        "urn_number": urnNumber,
        "fcra_number": fcraNumber,
        "pan_number": panNumber,
        "category_name": categoryName,
        "raised_amount": raisedAmount,
        "social_id_image": socialIdImage,
        "user_rating": userRating,
        "csr_request_flag": csrRequestFlag,
        "social_follow": socialFollow,
        "social_commit": socialCommit,
        "total_followers": totalFollowers,
        "total_committed": totalCommitted,
        "celebrity": List<dynamic>.from(celebrity.map((x) => x.toJson())),
        "agency": agency,
        "company": company,
        "top_volunteer": topVolunteer,
        "tie_up_data": List<dynamic>.from(tieUpData.map((x) => x.toJson())),
        "tie_up_by_csr_data": tieUpByCsrData,
        "top_donor": topDonor,
        "normal_campaign_data": normalCampaignData.toJson(),
        "sos_campaign_data": sosCampaignData.toJson(),
        "social_csr_campaign": socialCsrCampaign,
        "mutual_friend": mutualFriend,
        "volunteer_flag": volunteerFlag,
      };
}

class Celebrity {
  int id;
  int userId;
  String type;
  String name;
  String profileImage;
  String status;
  DateTime insertdate;
  DateTime updatetime;
  String socialPartnerId;
  String userType;

  Celebrity({
    required this.id,
    required this.userId,
    required this.type,
    required this.name,
    required this.profileImage,
    required this.status,
    required this.insertdate,
    required this.updatetime,
    required this.socialPartnerId,
    required this.userType,
  });

  factory Celebrity.fromJson(Map<String, dynamic> json) => Celebrity(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        name: json["name"],
        profileImage: json["profile_image"],
        status: json["status"],
        insertdate: DateTime.parse(json["insertdate"]),
        updatetime: DateTime.parse(json["updatetime"]),
        socialPartnerId: json["social_partner_id"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "name": name,
        "profile_image": profileImage,
        "status": status,
        "insertdate": insertdate.toIso8601String(),
        "updatetime": updatetime.toIso8601String(),
        "social_partner_id": socialPartnerId,
        "user_type": userType,
      };
}

class NormalCampaignData {
  int donatedAmount;
  String donationPercentage;
  int id;
  int socialPartnerId;
  String campaignMedia;
  String campaignName;
  String address;
  String city;
  String state;
  String country;
  String discription;
  DateTime startDate;
  String startTime;
  DateTime endDate;
  String endTime;
  String campaignMediaType;
  String campaignType;
  String type;
  int totalBudget;
  int needAmountRaised;
  String donatedVolunteerId;
  int intrested;
  int participated;
  int campaignNumber;
  String isVerify;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String campaignLink;
  String spentAmount;
  String taggedUsersIds;
  int totalParticipated;
  String campaignMediaUrl;
  DateTime sTime;
  DateTime eTime;
  String fcraVerifyFlag;
  String csrVerifyFlag;
  List<CampaignMediaList> campaignMediaList;

  NormalCampaignData({
    required this.donatedAmount,
    required this.donationPercentage,
    required this.id,
    required this.socialPartnerId,
    required this.campaignMedia,
    required this.campaignName,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.discription,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.campaignMediaType,
    required this.campaignType,
    required this.type,
    required this.totalBudget,
    required this.needAmountRaised,
    required this.donatedVolunteerId,
    required this.intrested,
    required this.participated,
    required this.campaignNumber,
    required this.isVerify,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.campaignLink,
    required this.spentAmount,
    required this.taggedUsersIds,
    required this.totalParticipated,
    required this.campaignMediaUrl,
    required this.sTime,
    required this.eTime,
    required this.fcraVerifyFlag,
    required this.csrVerifyFlag,
    required this.campaignMediaList,
  });

  factory NormalCampaignData.fromJson(Map<String, dynamic> json) =>
      NormalCampaignData(
        donatedAmount: json["donatedAmount"],
        donationPercentage: json["donationPercentage"],
        id: json["id"],
        socialPartnerId: json["social_partner_id"],
        campaignMedia: json["campaign_media"],
        campaignName: json["campaign_name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        discription: json["discription"],
        startDate: DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        endDate: DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        campaignMediaType: json["campaign_media_type"],
        campaignType: json["campaign_type"],
        type: json["type"],
        totalBudget: json["total_budget"],
        needAmountRaised: json["need_amount_raised"],
        donatedVolunteerId: json["donated_volunteer_id"],
        intrested: json["intrested"],
        participated: json["participated"],
        campaignNumber: json["campaign_number"],
        isVerify: json["is_verify"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        campaignLink: json["campaign_link"],
        spentAmount: json["spent_amount"],
        taggedUsersIds: json["tagged_users_ids"],
        totalParticipated: json["total_participated"],
        campaignMediaUrl: json["campaign_media_url"],
        sTime: DateTime.parse(json["s_time"]),
        eTime: DateTime.parse(json["e_time"]),
        fcraVerifyFlag: json["fcra_verify_flag"],
        csrVerifyFlag: json["csr_verify_flag"],
        campaignMediaList: List<CampaignMediaList>.from(
            json["campaign_media_list"]
                .map((x) => CampaignMediaList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "donatedAmount": donatedAmount,
        "donationPercentage": donationPercentage,
        "id": id,
        "social_partner_id": socialPartnerId,
        "campaign_media": campaignMedia,
        "campaign_name": campaignName,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "discription": discription,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "campaign_media_type": campaignMediaType,
        "campaign_type": campaignType,
        "type": type,
        "total_budget": totalBudget,
        "need_amount_raised": needAmountRaised,
        "donated_volunteer_id": donatedVolunteerId,
        "intrested": intrested,
        "participated": participated,
        "campaign_number": campaignNumber,
        "is_verify": isVerify,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "campaign_link": campaignLink,
        "spent_amount": spentAmount,
        "tagged_users_ids": taggedUsersIds,
        "total_participated": totalParticipated,
        "campaign_media_url": campaignMediaUrl,
        "s_time": sTime.toIso8601String(),
        "e_time": eTime.toIso8601String(),
        "fcra_verify_flag": fcraVerifyFlag,
        "csr_verify_flag": csrVerifyFlag,
        "campaign_media_list":
            List<dynamic>.from(campaignMediaList.map((x) => x.toJson())),
      };
}

class CampaignMediaList {
  int id;
  int campaignId;
  String image;
  String status;
  DateTime insertdate;
  DateTime updatetime;
  String postImage;

  CampaignMediaList({
    required this.id,
    required this.campaignId,
    required this.image,
    required this.status,
    required this.insertdate,
    required this.updatetime,
    required this.postImage,
  });

  factory CampaignMediaList.fromJson(Map<String, dynamic> json) =>
      CampaignMediaList(
        id: json["id"],
        campaignId: json["campaign_id"],
        image: json["image"],
        status: json["status"],
        insertdate: DateTime.parse(json["insertdate"]),
        updatetime: DateTime.parse(json["updatetime"]),
        postImage: json["post_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "campaign_id": campaignId,
        "image": image,
        "status": status,
        "insertdate": insertdate.toIso8601String(),
        "updatetime": updatetime.toIso8601String(),
        "post_image": postImage,
      };
}

class SosCampaignData {
  int donatedAmount;
  int donationPercentage;
  String daysLeft;
  int id;
  int socialPartnerId;
  String campaignMedia;
  String campaignName;
  String address;
  String city;
  String state;
  String country;
  String discription;
  DateTime startDate;
  String startTime;
  DateTime endDate;
  String endTime;
  String campaignMediaType;
  String campaignType;
  String type;
  int totalBudget;
  int needAmountRaised;
  String donatedVolunteerId;
  int intrested;
  int participated;
  int campaignNumber;
  String isVerify;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String campaignLink;
  String spentAmount;
  String taggedUsersIds;
  int totalParticipated;
  String socialPartnerName;
  String socialPartnerMediaUrl;
  int spId;
  String campaignMediaUrl;
  DateTime sTime;
  DateTime eTime;
  List<CampaignMediaList> campaignMediaList;

  SosCampaignData({
    required this.donatedAmount,
    required this.donationPercentage,
    required this.daysLeft,
    required this.id,
    required this.socialPartnerId,
    required this.campaignMedia,
    required this.campaignName,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.discription,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.campaignMediaType,
    required this.campaignType,
    required this.type,
    required this.totalBudget,
    required this.needAmountRaised,
    required this.donatedVolunteerId,
    required this.intrested,
    required this.participated,
    required this.campaignNumber,
    required this.isVerify,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.campaignLink,
    required this.spentAmount,
    required this.taggedUsersIds,
    required this.totalParticipated,
    required this.socialPartnerName,
    required this.socialPartnerMediaUrl,
    required this.spId,
    required this.campaignMediaUrl,
    required this.sTime,
    required this.eTime,
    required this.campaignMediaList,
  });

  factory SosCampaignData.fromJson(Map<String, dynamic> json) =>
      SosCampaignData(
        donatedAmount: json["donatedAmount"],
        donationPercentage: json["donationPercentage"],
        daysLeft: json["daysLeft"],
        id: json["id"],
        socialPartnerId: json["social_partner_id"],
        campaignMedia: json["campaign_media"],
        campaignName: json["campaign_name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        discription: json["discription"],
        startDate: DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        endDate: DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        campaignMediaType: json["campaign_media_type"],
        campaignType: json["campaign_type"],
        type: json["type"],
        totalBudget: json["total_budget"],
        needAmountRaised: json["need_amount_raised"],
        donatedVolunteerId: json["donated_volunteer_id"],
        intrested: json["intrested"],
        participated: json["participated"],
        campaignNumber: json["campaign_number"],
        isVerify: json["is_verify"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        campaignLink: json["campaign_link"],
        spentAmount: json["spent_amount"],
        taggedUsersIds: json["tagged_users_ids"],
        totalParticipated: json["total_participated"],
        socialPartnerName: json["social_partner_name"],
        socialPartnerMediaUrl: json["social_partner_media_url"],
        spId: json["sp_id"],
        campaignMediaUrl: json["campaign_media_url"],
        sTime: DateTime.parse(json["s_time"]),
        eTime: DateTime.parse(json["e_time"]),
        campaignMediaList: List<CampaignMediaList>.from(
            json["campaign_media_list"]
                .map((x) => CampaignMediaList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "donatedAmount": donatedAmount,
        "donationPercentage": donationPercentage,
        "daysLeft": daysLeft,
        "id": id,
        "social_partner_id": socialPartnerId,
        "campaign_media": campaignMedia,
        "campaign_name": campaignName,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "discription": discription,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "campaign_media_type": campaignMediaType,
        "campaign_type": campaignType,
        "type": type,
        "total_budget": totalBudget,
        "need_amount_raised": needAmountRaised,
        "donated_volunteer_id": donatedVolunteerId,
        "intrested": intrested,
        "participated": participated,
        "campaign_number": campaignNumber,
        "is_verify": isVerify,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "campaign_link": campaignLink,
        "spent_amount": spentAmount,
        "tagged_users_ids": taggedUsersIds,
        "total_participated": totalParticipated,
        "social_partner_name": socialPartnerName,
        "social_partner_media_url": socialPartnerMediaUrl,
        "sp_id": spId,
        "campaign_media_url": campaignMediaUrl,
        "s_time": sTime.toIso8601String(),
        "e_time": eTime.toIso8601String(),
        "campaign_media_list":
            List<dynamic>.from(campaignMediaList.map((x) => x.toJson())),
      };
}

class TieUpDatum {
  int id;
  int userId;
  int csrPartnerId;
  int socialPartnerId;
  String status;
  String tieUpType;
  DateTime insertdate;
  DateTime updatetime;
  String name;
  String profileImage;

  TieUpDatum({
    required this.id,
    required this.userId,
    required this.csrPartnerId,
    required this.socialPartnerId,
    required this.status,
    required this.tieUpType,
    required this.insertdate,
    required this.updatetime,
    required this.name,
    required this.profileImage,
  });

  factory TieUpDatum.fromJson(Map<String, dynamic> json) => TieUpDatum(
        id: json["id"],
        userId: json["user_id"],
        csrPartnerId: json["csr_partner_id"],
        socialPartnerId: json["social_partner_id"],
        status: json["status"],
        tieUpType: json["tie_up_type"],
        insertdate: DateTime.parse(json["insertdate"]),
        updatetime: DateTime.parse(json["updatetime"]),
        name: json["name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "csr_partner_id": csrPartnerId,
        "social_partner_id": socialPartnerId,
        "status": status,
        "tie_up_type": tieUpType,
        "insertdate": insertdate.toIso8601String(),
        "updatetime": updatetime.toIso8601String(),
        "name": name,
        "profile_image": profileImage,
      };
}
