import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

abstract class Networking {
  Future<http.Response> get(Uri url, {Map<String, String>? headers});
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}

class NetworkingImpl implements Networking {
  final IOClient client;

  NetworkingImpl({required this.client});

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await client.post(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }

  @override
  Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response = await client.delete(
      url,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }
}
