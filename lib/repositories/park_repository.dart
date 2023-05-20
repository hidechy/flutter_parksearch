// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/park.dart';

class ParkRepository {
  ///
  Future<List<Park>> getParkInfo() async {
    final result = <Park>[];

    const url = 'http://toyohide.work/BrainLog/api/getMetropolitanPark';

    http.Response? response;
    response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final decodedBody = jsonDecode(responseBody);

      for (var i = 0; i < decodedBody['data'].length; i++) {
        result.add(Park.fromJson(decodedBody['data'][i]));
      }
    } else {
      throw Exception('Failed to load news.');
    }

    return result;
  }
}
