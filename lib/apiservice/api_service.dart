import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import '../responses.dart';
import '../utilities/constanst.dart';

class ApiServices {
  static Future<Either<Failure, Success>> getResponse(String url) async {
    try {
      http.Response jsonResponse =
          await http.get(Uri.parse(url), headers: headers);
      Map response = jsonDecode(jsonResponse.body);
      print(response);
      if (jsonResponse.statusCode == 200) {
        return Right(Success(response));
      } else {
        return Left(
            Failure(response['message'], jsonResponse.statusCode.toString()));
      }
    } on SocketException {
      return Left(Failure('No internet Connection!!', ''));
    } catch (e) {
      return Left(Failure('$e', ''));
    }
  }

  static Future<Either<Failure, Success>> postResponse(
    String url,
    Map body,
  ) async {
    try {
      http.Response jsonResponse =
          await http.post(Uri.parse(url), body: body, headers: headers);

      Map response = jsonDecode(jsonResponse.body);

      if (jsonResponse.statusCode == 200) {
        return Right(Success(response));
      } else {
        return Left(
            Failure(response['message'], jsonResponse.statusCode.toString()));
      }
    } on SocketException {
      return Left(Failure('No Internet Connection', ''));
    } catch (e) {
      return Left(Failure('$e', ''));
    }
  }
}
