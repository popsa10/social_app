import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://fcm.googleapis.com/",
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String lang = "en",
    String token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token ?? "",
    };
    return await dio.get(url, queryParameters: query ?? null);
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAXmw0HGU:APA91bHBtVBVKBFPAWBjKAd1eXgfzm_77UjCczQPddL7SLlpiHGazVU4IOGfY8GAj33qsyj0MjxmylUqsaAEbKVSnKk_iUp-kn6k9A25UmFjjWxl6C2oOcqV-b3PC9SyUO--orQo67Rr",
    };
    return await dio.post(url, queryParameters: query ?? null, data: data);
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = "en",
    String token,
  }) {
    dio.options.headers = {
      "lang": lang,
      "Authorization": token ?? "",
      "Content-Type": "application/json",
    };
    return dio.put(url, queryParameters: query, data: data);
  }
}
