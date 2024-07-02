// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
  String otp;
  UserDetail userDetail;

  OtpModel({
    required this.otp,
    required this.userDetail,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        otp: json["otp"],
        userDetail: UserDetail.fromJson(json["user_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "otp": otp,
        "user_detail": userDetail.toJson(),
      };
}

class UserDetail {
  int id;
  String name;
  String email;
  String countryCode;
  String phone;
  String type;
  DateTime dob;
  String gender;
  String description;
  String educationLevel;
  String school;
  String college;
  String jobTitle;
  String country;
  String state;
  String city;
  dynamic address;
  dynamic organizationCountryCode;
  dynamic organizationPhone;
  String profileImage;
  String coverImage;
  String socialPartnerIds;
  int volunteerReference;
  String preferenceIds;
  String panNo;
  String numberOfPush;
  dynamic latitude;
  dynamic longitude;
  dynamic otp;
  String status;
  int notificationCount;
  int notificationOnFlag;
  String referralCode;
  DateTime insertdate;
  DateTime updatetime;
  String influencerFlag;
  String donorFlag;
  dynamic sector;
  dynamic familyMember;
  String token;
  dynamic webToken;
  String language;
  String deviceId;
  String deviceType;
  dynamic socialSubUserResponse;
  dynamic advertiserSubUserResponse;
  dynamic csrSubUserResponse;
  AdvertiserDetails advertiserDetails;
  SocialPartnerDetails socialPartnerDetails;
  dynamic csrPartnerDetails;

  UserDetail({
    required this.id,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.type,
    required this.dob,
    required this.gender,
    required this.description,
    required this.educationLevel,
    required this.school,
    required this.college,
    required this.jobTitle,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.organizationCountryCode,
    required this.organizationPhone,
    required this.profileImage,
    required this.coverImage,
    required this.socialPartnerIds,
    required this.volunteerReference,
    required this.preferenceIds,
    required this.panNo,
    required this.numberOfPush,
    required this.latitude,
    required this.longitude,
    required this.otp,
    required this.status,
    required this.notificationCount,
    required this.notificationOnFlag,
    required this.referralCode,
    required this.insertdate,
    required this.updatetime,
    required this.influencerFlag,
    required this.donorFlag,
    required this.sector,
    required this.familyMember,
    required this.token,
    required this.webToken,
    required this.language,
    required this.deviceId,
    required this.deviceType,
    required this.socialSubUserResponse,
    required this.advertiserSubUserResponse,
    required this.csrSubUserResponse,
    required this.advertiserDetails,
    required this.socialPartnerDetails,
    required this.csrPartnerDetails,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        countryCode: json["country_code"],
        phone: json["phone"],
        type: json["type"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        description: json["description"],
        educationLevel: json["education_level"],
        school: json["school"],
        college: json["college"],
        jobTitle: json["job_title"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address: json["address"],
        organizationCountryCode: json["organization_country_code"],
        organizationPhone: json["organization_phone"],
        profileImage: json["profile_image"],
        coverImage: json["cover_image"],
        socialPartnerIds: json["social_partner_ids"],
        volunteerReference: json["volunteer_reference"],
        preferenceIds: json["preference_ids"],
        panNo: json["pan_no"],
        numberOfPush: json["number_of_push"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        otp: json["otp"],
        status: json["status"],
        notificationCount: json["notification_count"],
        notificationOnFlag: json["notification_on_flag"],
        referralCode: json["referral_code"],
        insertdate: DateTime.parse(json["insertdate"]),
        updatetime: DateTime.parse(json["updatetime"]),
        influencerFlag: json["influencer_flag"],
        donorFlag: json["donor_flag"],
        sector: json["sector"],
        familyMember: json["family_member"],
        token: json["token"],
        webToken: json["web_token"],
        language: json["language"],
        deviceId: json["device_id"],
        deviceType: json["device_type"],
        socialSubUserResponse: json["social_sub_user_response"],
        advertiserSubUserResponse: json["advertiser_sub_user_response"],
        csrSubUserResponse: json["csr_sub_user_response"],
        advertiserDetails:
            AdvertiserDetails.fromJson(json["advertiser_details"]),
        socialPartnerDetails:
            SocialPartnerDetails.fromJson(json["social_partner_details"]),
        csrPartnerDetails: json["csr_partner_details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "type": type,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "description": description,
        "education_level": educationLevel,
        "school": school,
        "college": college,
        "job_title": jobTitle,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "organization_country_code": organizationCountryCode,
        "organization_phone": organizationPhone,
        "profile_image": profileImage,
        "cover_image": coverImage,
        "social_partner_ids": socialPartnerIds,
        "volunteer_reference": volunteerReference,
        "preference_ids": preferenceIds,
        "pan_no": panNo,
        "number_of_push": numberOfPush,
        "latitude": latitude,
        "longitude": longitude,
        "otp": otp,
        "status": status,
        "notification_count": notificationCount,
        "notification_on_flag": notificationOnFlag,
        "referral_code": referralCode,
        "insertdate": insertdate.toIso8601String(),
        "updatetime": updatetime.toIso8601String(),
        "influencer_flag": influencerFlag,
        "donor_flag": donorFlag,
        "sector": sector,
        "family_member": familyMember,
        "token": token,
        "web_token": webToken,
        "language": language,
        "device_id": deviceId,
        "device_type": deviceType,
        "social_sub_user_response": socialSubUserResponse,
        "advertiser_sub_user_response": advertiserSubUserResponse,
        "csr_sub_user_response": csrSubUserResponse,
        "advertiser_details": advertiserDetails.toJson(),
        "social_partner_details": socialPartnerDetails.toJson(),
        "csr_partner_details": csrPartnerDetails,
      };
}

class AdvertiserDetails {
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
  String address;
  String category;
  String location;
  String noOfPush;
  String bankName;
  String accountNumber;
  String accountHolderName;
  String ifscCode;
  String csrBudget;
  String profileImage;
  String coverImage;
  String idImage;
  int creditAmount;
  String status;
  String isVerify;
  DateTime insertdate;
  DateTime updatetime;

  AdvertiserDetails({
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
    required this.address,
    required this.category,
    required this.location,
    required this.noOfPush,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolderName,
    required this.ifscCode,
    required this.csrBudget,
    required this.profileImage,
    required this.coverImage,
    required this.idImage,
    required this.creditAmount,
    required this.status,
    required this.isVerify,
    required this.insertdate,
    required this.updatetime,
  });

  factory AdvertiserDetails.fromJson(Map<String, dynamic> json) =>
      AdvertiserDetails(
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
        address: json["address"],
        category: json["category"],
        location: json["location"],
        noOfPush: json["no_of_push"],
        bankName: json["bank_name"],
        accountNumber: json["account_number"],
        accountHolderName: json["account_holder_name"],
        ifscCode: json["IFSC_code"],
        csrBudget: json["CSR_budget"],
        profileImage: json["profile_image"],
        coverImage: json["cover_image"],
        idImage: json["id_image"],
        creditAmount: json["credit_amount"],
        status: json["status"],
        isVerify: json["is_verify"],
        insertdate: DateTime.parse(json["insertdate"]),
        updatetime: DateTime.parse(json["updatetime"]),
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
        "address": address,
        "category": category,
        "location": location,
        "no_of_push": noOfPush,
        "bank_name": bankName,
        "account_number": accountNumber,
        "account_holder_name": accountHolderName,
        "IFSC_code": ifscCode,
        "CSR_budget": csrBudget,
        "profile_image": profileImage,
        "cover_image": coverImage,
        "id_image": idImage,
        "credit_amount": creditAmount,
        "status": status,
        "is_verify": isVerify,
        "insertdate": insertdate.toIso8601String(),
        "updatetime": updatetime.toIso8601String(),
      };
}

class SocialPartnerDetails {
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
  dynamic city;
  dynamic state;
  dynamic country;
  int volunteerCertificateDuration;
  dynamic urnNumber;
  dynamic fcraNumber;
  dynamic panNumber;
  String categoryIdsList;
  String categoryName;
  bool profileCompleteFlag;
  dynamic isSelectedCampaing;

  SocialPartnerDetails({
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
    required this.categoryIdsList,
    required this.categoryName,
    required this.profileCompleteFlag,
    required this.isSelectedCampaing,
  });

  factory SocialPartnerDetails.fromJson(Map<String, dynamic> json) =>
      SocialPartnerDetails(
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
        categoryIdsList: json["category_ids_list"],
        categoryName: json["category_name"],
        profileCompleteFlag: json["profile_complete_flag"],
        isSelectedCampaing: json["is_selected_campaing"],
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
        "category_ids_list": categoryIdsList,
        "category_name": categoryName,
        "profile_complete_flag": profileCompleteFlag,
        "is_selected_campaing": isSelectedCampaing,
      };
}
