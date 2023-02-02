import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/model/response_model.dart';

abstract class ApiHelper {
  // Stream<bool> get tokenExpriedStream;
  Future<ResponseModel> getMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  });
  Future<ResponseModel> postMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  });
  Future<ResponseModel> putMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  });
  Future<ResponseModel> deleteMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  });
  Future<dynamic> postFile(
    String url, {
    Map<String, String>? body,
    Map<String, String> headers = const {},
    required File file,
    required String photoNameField,
  });
  Future<ResponseModel> putFile(
    String url, {
    Map<String, String>? body,
    Map<String, String> headers = const {},
    required File file,
    required String photoNameField,
  });
}

class ApiHelperImpl implements ApiHelper {
  // final tokenExpriedController = StreamController<bool>.broadcast();
  // @override
  // Stream<bool> get tokenExpriedStream => tokenExpriedController.stream;
  final Map<String, String> _baseHeaders = {
    "Content-type": "application/json",
    "Accept": "application/json",
  };

  Uri _createUri(String path) {
    Uri uri = Uri.parse(path);
    // uri = Uri.https(authority, path, queryParameters);

    // if (_baseApiUrl.contains("dev") || _baseApiUrl.contains('192.168.')) {
    //   uri = Uri.http(authority, path, queryParameters);
    // } else {
    //   uri = Uri.https(authority, path, queryParameters);
    // }
    return uri;
  }

  @override
  Future<ResponseModel> getMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  }) async {
    Uri uri = _createUri(url);
    _baseHeaders.addAll(headers);
    _logRequest(url, "GET", body, _baseHeaders);
    http.Response response = await http.get(
      uri,
      headers: headers,
    );
    int statusCode = response.statusCode;
    _logResponse(url, statusCode, response.body);
    var responseHandled = _handleResponse(response);
    return responseHandled;
  }

  @override
  Future<ResponseModel> postMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  }) async {
    Uri uri = _createUri(url);
    _baseHeaders.addAll(headers);

    _logRequest(uri.toString(), "POST", body, _baseHeaders);
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: body != null ? json.encode(body) : null,
    );
    _logResponse(url, response.statusCode, response.body);
    return _handleResponse(response);
  }

  @override
  Future<ResponseModel> putMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  }) async {
    Uri uri = _createUri(url);
    _baseHeaders.addAll(headers);

    _logRequest(uri.toString(), "PUT", body, _baseHeaders);
    http.Response response = await http.put(
      uri,
      headers: headers,
      body: json.encode(body ?? {}),
    );
    _logResponse(url, response.statusCode, response.body);
    return _handleResponse(response);
  }

  @override
  Future<ResponseModel> deleteMethod(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String> headers = const {},
  }) async {
    Uri uri = _createUri(url);
    _logRequest(uri.toString(), "DELETE", body, headers);
    _baseHeaders.addAll(headers);
    http.Response response = await http.delete(
      uri,
      headers: _baseHeaders,
    );
    _logResponse(url, response.statusCode, response.body);
    return _handleResponse(response);
  }

  @override
  Future<dynamic> postFile(
    url, {
    Map<String, String>? body,
    Map<String, String> headers = const {},
    required File file,
    required String photoNameField,
  }) async {
    Uri uri = _createUri(url);
    var request = http.MultipartRequest('POST', uri);
    _baseHeaders.addAll(headers);
    request.headers.addAll(_baseHeaders);
    request.fields.addAll(body ?? {});
    request.files.add(
      await http.MultipartFile.fromPath(
        photoNameField,
        file.path,
      ),
    );
    _logRequest(url, "POST", body, headers);
    var response = await request.send();
    String responseBody = await response.stream.bytesToString();
    _logResponse(url, response.statusCode, responseBody);
    int statusCode = response.statusCode;
    if (200 >= statusCode && statusCode <= 299) {
      return ResponseModel.fromJson(json.decode(responseBody));
    }
    if (400 <= statusCode && statusCode <= 499) {
      throw Exception(json.decode(responseBody)["message"]);
    } else if (500 <= response.statusCode && response.statusCode <= 599) {
      throw Exception("Server Error");
    } else {
      return ResponseModel.fromJson(json.decode(responseBody));
    }
  }

  @override
  Future<ResponseModel> putFile(
    url, {
    param,
    Map<String, String>? body,
    Map<String, String> headers = const {},
    required File file,
    required String photoNameField,
  }) async {
    Uri uri = _createUri(url);
    var request = http.MultipartRequest('PUT', uri);
    _baseHeaders.addAll(headers);

    request.headers.addAll(_baseHeaders);
    request.fields.addAll(body ?? {});
    request.files.add(
      await http.MultipartFile.fromPath(
        photoNameField,
        file.path,
      ),
    );
    _logRequest(url, "PUT", body, headers);
    var response = await request.send();
    String responseBody = await response.stream.bytesToString();
    _logResponse(url, response.statusCode, responseBody);
    int statusCode = response.statusCode;
    if (200 >= statusCode && statusCode <= 299) {
      return ResponseModel.fromJson(json.decode(responseBody));
    }
    if (400 <= statusCode && statusCode <= 499) {
      throw Exception(json.decode(responseBody)["message"]);
    } else if (500 <= response.statusCode && response.statusCode <= 599) {
      throw Exception("Server Error");
    } else {
      return ResponseModel.fromJson(json.decode(responseBody));
    }
  }

  ResponseModel _handleResponse(http.Response response) {
    var body = jsonDecode(response.body);
    ResponseModel responseModel =
        ResponseModel.fromJson(body, bodyByte: response.bodyBytes);
    return responseModel;
    // if (200 >= statusCode && statusCode <= 299) {
    //   ResponseModel responseModel =
    //       ResponseModel.fromJson(body, bodyByte: response.bodyBytes);
    //   if (!responseModel.success) {
    //     throw responseModel.message ?? "Request API Error";
    //   }
    //   return ResponseModel.fromJson(jsonDecode(response.body));
    // }
    // if (400 <= statusCode && statusCode <= 499) {
    //   throw Exception(json.decode(response.body)["message"]);
    // } else if (500 <= response.statusCode && response.statusCode <= 599) {
    //   if (response.body.isNotEmpty) {
    //     var jsonDecode = json.decode(response.body);
    //     if (jsonDecode['message'] == 'jwt expired') {
    //       // tokenExpriedController.add(true);
    //     }
    //     throw Exception(jsonDecode["message"]);
    //   }
    //   throw Exception("Server Error");
    // } else {
    //   return ResponseModel.fromJson(jsonDecode(response.body));
    // }
  }

  void _logRequest(
      String url, String method, dynamic body, Map<String, String> headers) {
    if (kDebugMode) {
      print(
          "====================================================================================");
      print("[${method.toUpperCase()}]");
      print("REQUEST TO API: $url With: \n");
      print("HEADER: $headers\n");
      print("BODY: $body\n");
      print(
          "====================================================================================");
    }
  }

  void _logResponse(String url, int statusCode, String body) {
    if (kDebugMode) {
      print(
          "====================================================================================");
      print("RESPONSE API: $url With: \n");
      print("STATUS CODE: $statusCode \n");
      print("BODY: $body \n");
      print(
          "====================================================================================");
    }
  }

  // void dispose() {
  //   tokenExpriedController.close();
  // }
}
