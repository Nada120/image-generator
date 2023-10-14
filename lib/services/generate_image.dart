import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helper/token.dart';
import '../helper/url.dart';

class GenerateImage {
  Future<Uint8List> generateImage({required String text}) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: json.encode(<String, dynamic>{"inputs": text}),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var image = response.bodyBytes;
        return image;
      } else {
        debugPrint('The Status Code: ${response.statusCode}');
        throw Error();
      }
    } catch (e) {
      throw Error();
    }
  }
}
