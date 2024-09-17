import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? userName;
  String? userFirst;
  String? userLast;
  String? userEmail;
  PhoneNumberModel? userPhone;
  String? userImage;
  String? userGender;
  String? userDateBirth;
  String? lastActive;
  String? about;
  bool? isOnline;
  String? pushToken;
  String? accountDateCreation;
  String? providerType;

  UserModel({
    this.userId,
    this.userEmail,
    this.userName,
    this.userFirst,
    this.userLast,
    this.userPhone,
    this.userImage,
    this.userGender,
    this.userDateBirth,
    this.lastActive,
    this.about,
    this.isOnline,
    this.pushToken,
    this.accountDateCreation,
    required this.providerType,
  });

  static UserModel empty() => UserModel(
        userId: '',
        userEmail: '',
        userName: '',
        userFirst: '',
        userLast: '',
        userPhone: PhoneNumberModel(phoneNumber: '', countryCode: ''),
        userImage: '',
        userGender: '',
        userDateBirth: '',
        lastActive: '',
        about: '',
        isOnline: false,
        pushToken: '',
        accountDateCreation: '',
        providerType: '',
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_id': userId,
      'user_name': userName,
      'user_first': userFirst,
      'user_last': userLast,
      'user_email': userEmail,
      'user_phone': userPhone?.toJson(),
      'user_image': userImage,
      'user_gendar': userGender,
      'user_date_birth': userDateBirth,
      'user_about': about,
      'is_online': isOnline,
      'push_token': pushToken,
      'user_last_active': lastActive,
      'user_account_created_date': accountDateCreation,
      'provider_type': providerType,
    };
  }

  static List<String> nameParts(fullName) => fullName.split(' ');
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.toString().split(' ');
    String firstName = nameParts[0].toLowerCase();
    if (nameParts.length > 1) {
      String lastName = nameParts[1].toLowerCase();
      String camelCaseUserName = "$firstName$lastName";
      String userNameWithPrefix = "mr_$camelCaseUserName";
      return userNameWithPrefix;
    }
    return "mr_$firstName";
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot,
  ) {
    if (documentSnapshot.data() != null) {
      final data = documentSnapshot.data();
      return UserModel(
        userId: data?['user_id'] ?? "",
        userName: data?['user_name'] ?? "",
        userFirst: data?['user_first'] ?? "",
        userLast: data?['user_last'] ?? "",
        userEmail: data?['user_email'] ?? "",
        userPhone: data?['user_phone'] != null
            ? PhoneNumberModel.fromJson(data?['user_phone'])
            : null,
        userImage: data?['user_image'] ?? "",
        userGender: data?['user_gendar'] ?? "",
        userDateBirth: data?['user_date_birth'] ?? "",
        lastActive: data?['user_last_active'] ?? "",
        about: data?['user_about'] ?? "",
        isOnline: data?['is_online'] ?? false,
        pushToken: data?['push_token'] ?? "",
        accountDateCreation: data?['user_account_created_date'] ?? "",
        providerType: data?['provider_type'] ?? "",
      );
    } else {
      return UserModel.empty();
    }
  }
  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userFirst = json['user_first'];
    userLast = json['user_last'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'] != null
        ? PhoneNumberModel.fromJson(json['user_phone'])
        : null;
    userImage = json['user_image'];
    userGender = json['user_gendar'];
    userDateBirth = json['user_date_birth'];
    lastActive = json['user_last_active'];
    about = json['user_about'];
    isOnline = json['is_online'];
    pushToken = json['push_token'];
    accountDateCreation = json['user_account_created_date'];
    providerType = json['provider_type'];
  }

  UserModel copyWith({
    String? userId,
    String? userName,
    String? userFirst,
    String? userLast,
    String? userEmail,
    PhoneNumberModel? userPhone,
    String? userImage,
    String? userGender,
    String? userDateBirth,
    String? lastActive,
    String? about,
    bool? isOnline,
    String? pushToken,
    String? accountDateCreation,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userFirst: userFirst ?? this.userFirst,
      userLast: userLast ?? this.userLast,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userImage: userImage ?? this.userImage,
      userGender: userGender ?? this.userGender,
      userDateBirth: userDateBirth ?? this.userDateBirth,
      lastActive: lastActive ?? this.lastActive,
      about: about ?? this.about,
      isOnline: isOnline ?? this.isOnline,
      pushToken: pushToken ?? this.pushToken,
      accountDateCreation: accountDateCreation ?? this.accountDateCreation,
      providerType: providerType ?? this.providerType,
    );
  }
}

class PhoneNumberModel {
  String? phoneNumber;
  String? countryCode;

  PhoneNumberModel({
    required this.phoneNumber,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone_number': phoneNumber,
      'country_code': countryCode,
    };
  }

  PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
  }

  PhoneNumberModel copyWith({
    String? phoneNumber,
    String? countryCode,
  }) {
    return PhoneNumberModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
