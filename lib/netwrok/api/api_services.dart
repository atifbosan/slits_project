import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'dart:core';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:slits_project/netwrok/root/url_root.dart';
import 'package:slits_project/preference/mypreferences.dart';
import 'package:slits_project/screen/favourites/model/favourite_model.dart';
import 'package:slits_project/screen/signup/model/user_model.dart';
import 'package:slits_project/screen/stdSuggestion/model/suggestion_model.dart';
import 'package:slits_project/screen/teacherTutorial/addTutorial/model/video_add_model.dart';
import 'package:slits_project/screen/tutorial/model/video_streaming_model.dart';

import '../../screen/teacherTutorial/AdminSuggestion/model/admin_suggestion_model.dart';

class ApiServices {
  static var client = http.Client();
  static Future<String> login(
      String email, String password, String user_type) async {
    Map map = Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    map['user_type'] = user_type;
    final userdata = GetStorage();
    var response = await client.post(Uri.parse(UrlRoot.LOGIN), body: map);

    if (response.statusCode == 200) {
      String jsonString = response.body;
      var convertJson = jsonDecode(jsonString);
      String message = convertJson['message'];
      var user = jsonDecode(response.body);
      print(response.body);

      if (message == "You are logged in successfully") {
        MyPref.instance.setStringValue("user_id", user['user']['user_id']);
        MyPref.instance.setStringValue("name", user['user']['name']);
        MyPref.instance.setStringValue("email", user['user']['email']);
        MyPref.instance.setStringValue("user_type", user['user']['user_type']);
      }

      return message;
    } else {
      return "connection error";
    }
  }

  static Future<String> registration(UserModel userModel) async {
    var response = await client.post(Uri.parse(UrlRoot.RESGITRATION),
        body: userModel.toMap());
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var convertJson = jsonDecode(jsonString);
      String message = convertJson['message'];
      return message;
    } else {
      return "Connection Problem";
    }
  }

  static Future<List<VideoStreamingModel>> getVideoStream() async {
    List<VideoStreamingModel> videoModel = [];
    var response = await client.get(Uri.parse(UrlRoot.VIDEOSTREAMING));
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      videoModel = items.map<VideoStreamingModel>((json) {
        return VideoStreamingModel.fromMap(json);
      }).toList();
      return videoModel;
    } else {
      return videoModel;
    }
  }

  static Future<String> deleteData(String v_id) async {
    Map map = Map<String, dynamic>();
    map['category'] = "delete";
    map['v_id'] = v_id;
    print(map);
    var response = await client.post(Uri.parse(UrlRoot.VIDEOSADMIN), body: map);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var convertJson = jsonDecode(jsonString);
      String message = convertJson['message'];
      return message;
    } else {
      return "connection problem";
    }
  }

  static Future<String> updateVideoData(
      String v_id, String title, String description) async {
    Map map = Map<String, dynamic>();
    map['category'] = "update";
    map['v_id'] = v_id;
    map['v_title'] = title;
    map['v_description'] = description;
    print(map);
    var response = await client.post(Uri.parse(UrlRoot.VIDEOSADMIN), body: map);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var convertJson = jsonDecode(jsonString);
      String message = convertJson['message'];
      return message;
    } else {
      return "connection problem";
    }
  }

  static Future<List<SuggestionModel>> fetchSuggestion(String user_id) async {
    List<SuggestionModel> model = [];
    var map = Map<String, dynamic>();
    map['user_id'] = user_id;
    map['category'] = 'fetch';
    var response =
        await client.post(Uri.parse(UrlRoot.USER_SUGGESTION), body: map);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      model = items.map<SuggestionModel>((json) {
        return SuggestionModel.fromJson(json);
      }).toList();
      return model;
    } else {
      return model;
    }
  }

  static Future<String> sendSuggestion(SuggestionModel model) async {
    print(model.toJson());
    var response = await client.post(Uri.parse(UrlRoot.USER_SUGGESTION),
        body: model.toJson());
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var jsonConvert = jsonDecode(jsonString);
      String message = jsonConvert['message'];
      return message;
    } else {
      return "connection error";
    }
  }

  static Future<List<AdminSuggestionModel>> fetchAdminMsg() async {
    List<AdminSuggestionModel> models = [];
    var map = Map<String, dynamic>();
    map['category'] = "fetch";
    var response =
        await client.post(Uri.parse(UrlRoot.ADMIN_SUGGESTION), body: map);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      models = items.map<AdminSuggestionModel>((json) {
        return AdminSuggestionModel.fromJson(json);
      }).toList();
      return models;
    } else {
      return models;
    }
  }

  static Future<String> updateStatus(String s_id) async {
    var map = Map<String, dynamic>();
    map['s_id'] = s_id;
    var response =
        await client.post(Uri.parse(UrlRoot.UPDATE_SUGGESTION), body: map);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var jsonConvert = jsonDecode(jsonString);
      String message = jsonConvert['message'];
      return message;
    } else {
      return "connection error";
    }
  }

  static Future<String> reply(AdminSuggestionModel model) async {
    var response = await client.post(Uri.parse(UrlRoot.ADMIN_SUGGESTION),
        body: model.toJson());
    print(model.toJson());
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var jsonConvert = jsonDecode(jsonString);
      String message = jsonConvert['message'];
      return message;
    } else {
      return "connection problem";
    }
  }

  static Future<String> addFavourite(FavouriteModel model) async {
    var response = await http.post(Uri.parse(UrlRoot.favourite_VIDEOS),
        body: model.toJson());
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var jsonConvert = jsonDecode(jsonString);
      String message = jsonConvert['message'];
      return message;
    } else {
      return "connection error";
    }
  }

  static Future<String> deleteFavourite(String user_id, String v_id) async {
    var map = Map<String, dynamic>();
    map['user_id'] = user_id;
    map['v_id'] = v_id;
    map['category'] = "delete";
    var response =
        await http.post(Uri.parse(UrlRoot.favourite_VIDEOS), body: map);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      var jsonConvert = jsonDecode(jsonString);
      String message = jsonConvert['message'];
      return message;
    } else {
      return "connection error";
    }
  }

  static Future<List<FavouriteModel>> fetchFavourite(String user_id) async {
    List<FavouriteModel> model = [];
    var map = Map<String, dynamic>();
    map['user_id'] = "$user_id";
    map['category'] = "fetch";
    var response =
        await http.post(Uri.parse(UrlRoot.favourite_VIDEOS), body: map);
    if (response.statusCode == 200) {
      final items = json.decode(response.body);
      model = items.map<FavouriteModel>((json) {
        return FavouriteModel.fromJson(json);
      }).toList();
      return model;
    } else {
      return model;
    }
  }
}
