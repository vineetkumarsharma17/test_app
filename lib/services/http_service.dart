import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../helper/helper.dart';
import '../views/widgets/show_loading.dart';

typedef ProgressUpdate = void Function(int sentBytes, int totalBytes);

enum HttpRequest { get, put, post, delete, upload }

class HttpService {
  http.Client? ioClient;
  static final HttpService instance = HttpService._internal();
  HttpService._internal();

  factory HttpService(http.Client ioClient) {
    instance.ioClient = ioClient;
    return instance;
  }

  final GetStorage storage = GetStorage();
  final String _baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<Map<String, dynamic>?> _request(HttpRequest type, String url, Map data,
      [filePaths, ProgressUpdate? onProgressUpdate]) async {
    debugPrint(
        '--------------------------------------------------------------------------------------');
    debugPrint('$type - $url');
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
      if (data != null) {
        log(jsonEncode(data));
      }
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
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));

        /* response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(data));*/
      }

      if (type == HttpRequest.delete) {
        response = await http.delete(Uri.parse(url), headers: headers);
      }
      final endTime = DateTime.now().millisecondsSinceEpoch;
      debugPrint(
          '$type - $url, status: ${response.statusCode}, response time: ${(endTime - startTime) / 1000}s');
      var body = type == HttpRequest.upload
          ? jsonDecode(await response.stream.bytesToString())
          : jsonDecode(response.body);
      log('Response body: ${jsonEncode(body)}');
      return body;
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
  // Future<AuthResponseModel?> login(AuthRequestModel requestModel) async {
  //   var res = await _request(
  //       HttpRequest.post, '$_baseUrl/api/v1/auth/login', requestModel.toJson());
  //   if (res != null) return AuthResponseModel.fromJson(res);
  //   return null;
  // }
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
