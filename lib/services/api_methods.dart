import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:krishivikas/services/save_user_info.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class ApiMethods {
  Future postData(Map<String, dynamic> data, String url) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json;charset=UTF-8",
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["response"];
      } else {
        return "Server Error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> postDataForLogin(
      Map<String, dynamic> data, String url) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json;charset=UTF-8",
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getDataByPostApi(Map<String, dynamic> data, String url) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json;charset=UTF-8",
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getCitiesByPostApi(String url, int stateId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"state_id": stateId}),
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getBrandsByPostApi(String url, int categoryId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"category": categoryId}),
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future getUserInfoByPostApi(
      String url, int userId, String token) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"user_id": userId, "user_token": token}),
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getSingleTractorInfoById(
      String url, int userId, String token, int tractorId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "last_id": tractorId
          }),
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getTractorsByPostApi(
      String url, int userId, String token, int skip, int take) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "skip": skip,
            "take": take
          }),
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getModelsByPostApi(
      String url, int categoryId, int brandId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "category_id": categoryId,
            "brand_id": brandId,
          }),
          headers: {
            "Content-Type": "application/json;charset=UTF-8",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List> getData(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> postMasterBrandData(String url) async {
    try {
      var response = await http.post(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)["data"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteData(String id, String url) async {
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return "deleted";
      } else {
        return "Server Error";
      }
    } catch (e) {
      return e;
    }
  }

  Future updateData(String id, Map<String, String> data, String url) async {
    try {
      var response = await http.put(
        Uri.parse(url),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return "updated";
      } else {
        return "Server Error";
      }
    } catch (e) {
      return e;
    }
  }

  Future<List> searchUserByName(String searchedUser, String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
