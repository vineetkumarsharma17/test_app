import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_app/helper/app_export.dart';
import 'package:test_app/models/product.dart';
import 'package:test_app/models/user_model.dart';
import '../helper/helper.dart';
import '../models/api_error.dart';
import '../views/widgets/show_loading.dart';
import 'package:http_parser/http_parser.dart';

typedef ProgressUpdate = void Function(int sentBytes, int totalBytes);

enum HttpRequest { get, put, post, delete, multipart }

class HttpService {
  http.Client? ioClient;
  static final HttpService instance = HttpService._internal();
  HttpService._internal();

  factory HttpService(http.Client ioClient) {
    instance.ioClient = ioClient;
    return instance;
  }

  final GetStorage storage = GetStorage();
  final String _baseUrl = "https://shareittofriends.com";
  // final String _baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future _request(HttpRequest type, String url, data,
      [filePaths, ProgressUpdate? onProgressUpdate]) async {
    log(url);
    debugPrint(
        '--------------------------------------------------------------------------------------');
    log('$type - $url');
    log('data - $data');
    final headers = {
      'Content-Type': 'application/json',
    };

    String? token = storage.read('token');

    try {
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
      debugPrint(headers.toString());

      var response;
      final startTime = DateTime.now().millisecondsSinceEpoch;
      if (type == HttpRequest.get) {
        response = await http.get(
            Uri.parse(
              url,
            ),
            headers: headers);
      }
      if (type == HttpRequest.put) {
        response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(data));

        /*  response = await http.put(Uri.parse(url),
            headers: headers, body: jsonEncode(data));*/
      }
      if (type == HttpRequest.post) {
        response =
            await http.post(Uri.parse(url), headers: headers, body: data);

        /* response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));*/
      }

      if (type == HttpRequest.delete) {
        response = await http.delete(Uri.parse(url), headers: headers);
      }
      if (type == HttpRequest.multipart) {
        var request = MultipartRequest('POST', Uri.parse(url),
            onProgress: (int bytes, int total) {
          onProgressUpdate?.call(bytes, total);
        });
        request.headers.addAll(headers);
        request.fields.addAll(data);
        if (filePaths != null && filePaths.length > 0) {
          for (var file in filePaths) {
            debugPrint('adding file: $file');
            request.files
                .add(await http.MultipartFile.fromPath('files', file.path));
          }
        }
        response = await request.send();
      }
      final endTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint(
          '$type - $url, status: ${response.statusCode}, response time: ${(endTime - startTime) / 1000}s');
      var body = type == HttpRequest.multipart
          ? jsonDecode(await response.stream.bytesToString())
          : jsonDecode(response.body);
      if (response.statusCode == 200) {
        log('Response body: ${jsonEncode(body)}');
        return body;
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        throw ApiError(
            statusCode: response.statusCode,
            message: body['message'],
            title: body['title']);
      }
    } on ApiError catch (e) {
      dismissLoadingWidget();
      debugPrint('Api error: $e');
      Helpers.toast(e.message);
      return null;
    } on SocketException catch (e) {
      dismissLoadingWidget();
      debugPrint('SocketException: $e');
      Helpers.toast("No internet connection.");
    } catch (e, st) {
      dismissLoadingWidget();
      log("error $e");
      Helpers.toast('Something went wrong.');
      debugPrintStack(stackTrace: st);
    }
    return Future(() => {});
  }

  // // login api request
  Future<User?> login(Map<String, String> data) async {
    var res = await _request(
        HttpRequest.multipart, '$_baseUrl/demo/flutter/Login.php', data);
    if (res != null) return User.fromJson(res['data']);
  }

  // // Signup api request
  Future<User?> register(Map<String, String> data) async {
    var res = await _request(
        HttpRequest.multipart, '$_baseUrl/demo/flutter/Register.php', data);
    log("responsdffaf $res");
    if (res != null) return User.fromJson(res['data']);
  }

  // // Add product  api request
  Future addProduct(Map<String, String> data) async {
    var res = await _request(
        HttpRequest.multipart, '$_baseUrl/demo/flutter/addProduct.php', data);
    return res;
  }

  // // update product  api request
  Future updateProduct(Map<String, String> data) async {
    var res = await _request(
        HttpRequest.multipart, '$_baseUrl/demo/flutter/editProduct.php', data);
    return res;
  }

  // // delete product  api request
  Future deleteProduct(Map<String, String> data) async {
    var res = await _request(HttpRequest.multipart,
        '$_baseUrl/demo/flutter/deleteProduct.php', data);
    return res;
  }

  // // get product  List
  Future<List<Product>> getProducts() async {
    Map<String, String> data = {
      "user_login_token": appController.user.value!.userToken!
    };
    var res = await _request(
        HttpRequest.multipart, '$_baseUrl/demo/flutter/productList.php', data);

    if (res != null) {
      List<Product> products = [];
      for (var x in res) {
        products.add(Product.fromJson(x));
      }

      return products;
    }

    return [];
  }
}

// Multipart request
class MultipartRequest extends http.MultipartRequest {
  /// Creates a new [MultipartRequest].
  MultipartRequest(String method, Uri url, {required this.onProgress})
      : super(method, url);

  final void Function(int bytes, int totalBytes) onProgress;

  /// Freezes all mutable fields and returns a
  /// single-subscription [http.ByteStream]
  /// that will emit the request body.
  @override
  http.ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    var bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress.call(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return http.ByteStream(stream);
  }
}
