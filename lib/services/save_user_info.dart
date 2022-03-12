import 'package:flutter/material.dart';
import 'package:krishivikas/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFunctions {
  static String? name;
  static String? phoneNumber;
  static String? email;
  static String? state;
  static String? district;
  static int? userId;
  static String? token;
  static int? isRegistered;
  static int? zipcode;
  static String? stateName;
  static String? cityName;
  static String? districtName;
  static int? countryId;
  static int? stateId;
  static int? cityId;
  static int? districtId;
  static double? latitude;
  static double? longitude;
  static String? deviceToken;

  saveDeviceToken(String deviceToken) {
    prefs!.setString("DEVICETOKEN", deviceToken);
  }

  getDeviceToken() async {
    deviceToken = await prefs!.getString("DEVICETOKEN");
  }

  saveUserId(int userId) {
    prefs!.setInt("USERID", userId);
  }

  getUserId() async {
    userId = await prefs!.getInt("USERID");
  }

  saveToken(String token) {
    prefs!.setString("TOKEN", token);
  }

  getToken() async {
    token = await prefs!.getString("TOKEN");
  }

  saveIsRegistered(int isRegistered) {
    prefs!.setInt("REGISTERED", isRegistered);
  }

  getIsRegistered() async {
    isRegistered = await prefs!.getInt("REGISTERED");
  }

  saveUserPhoneNumber(String userPhoneNumber) {
    prefs!.setString("PHONENUMBER", userPhoneNumber);
  }

  getUserPhoneNumber() async {
    phoneNumber = await prefs!.getString("PHONENUMBER");
  }

  saveUserEmail(String userEmail) {
    prefs!.setString("EMAIL", userEmail);
  }

  getUserEmail() async {
    phoneNumber = await prefs!.getString("EMAIL");
  }

  saveUserZipcode(int zipcode) {
    prefs!.setInt("ZIPCODE", zipcode);
  }

  getUserZipcode() async {
    zipcode = await prefs!.getInt("ZIPCODE");
  }

  saveCountryId(int countryId) {
    prefs!.setInt("COUNTRYID", countryId);
  }

  getCountryId() async {
    countryId = await prefs!.getInt("COUNTRYID");
  }

  saveStateId(int stateId) {
    prefs!.setInt("STATEID", stateId);
  }

  getStateId() async {
    stateId = await prefs!.getInt("STATEID");
  }

  saveCityId(int cityId) {
    prefs!.setInt("CITYID", cityId);
  }

  getCityId() async {
    cityId = await prefs!.getInt("CITYID");
  }

  saveDistrictId(int districtId) {
    prefs!.setInt("DISTRICTID", districtId);
  }

  getDistrictId() async {
    cityId = await prefs!.getInt("DISTRICTID");
  }

  saveLatitude(double latitude) {
    prefs!.setDouble("LATITUDE", latitude);
  }

  getLatitude() async {
    latitude = await prefs!.getDouble("LATITUDE");
  }

  saveLongitude(double longitude) {
    prefs!.setDouble("LONGITUDE", longitude);
  }

  getLongitude() async {
    latitude = await prefs!.getDouble("LONGITUDE");
  }

  saveStateName(String stateName) {
    prefs!.setString("STATE", stateName);
  }

  getStateName() async {
    stateName = await prefs!.getString("STATE");
  }

  saveCityName(String cityName) {
    prefs!.setString("CITY", cityName);
  }

  getCityName() async {
    cityName = await prefs!.getString("CITY");
  }

  saveDistrictName(String districtName) {
    prefs!.setString("DISTRICT", districtName);
  }

  getDistrictName() async {
    districtName = await prefs!.getString("DISTRICT");
  }

  // saveUserInfo(String name, String phoneNumber, String email, String state,
  //     String district) {
  //   prefs!.setString("NAME", name);
  //   prefs!.setString("PHONENYMBER", phoneNumber);
  //   prefs!.setString("EMAIL", email);
  //   prefs!.setString("STATE", state);
  //   prefs!.setString("DISTRICT", district);
  // }

  // getUserInfo() async {
  //   name = await prefs!.getString("NAME");
  //   phoneNumber =await prefs!.getString("PHONENYMBER");
  //   email =await prefs!.getString("EMAIL");
  //   state =await prefs!.getString("STATE");
  //   district =await prefs!.getString("DISTRICT");
  // }
}
