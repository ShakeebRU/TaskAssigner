import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkAPIService {
  static Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      // print(response);
      responseJson = returnResponse(response);
    } on SocketException {
      // print("internet connection lost");
      return {"message": "internet connection lost"};
    } catch (error) {
      print("error : $error");
      return {"message": error.toString()};
    }
    return responseJson;
  }

  static Future getHeaderGetApiResponse(String url, String auth) async {
    dynamic responseJson;
    Map<String, String> header = {"Authorization": "Bearer $auth"};
    try {
      final response = await http.get(Uri.parse(url), headers: header);
      // print(response);
      responseJson = returnResponse(response);
    } on SocketException {
      // print("internet connection lost");
      return {"message": "internet connection lost"};
    }
    return responseJson;
  }

  static Future getPostApiResponse(String url, String auth) async {
    dynamic responseJson;
    Map<String, String> header = {"Authorization": "Bearer $auth"};
    try {
      Response response = await post(Uri.parse(url), headers: header);
      responseJson = returnResponse(response);
    } on SocketException {
      // print("internet connection lost");
      return {"message": "internet connection lost"};
    } catch (error) {
      // print("error : $error");
      return {"message": error.toString()};
    }
    // print("response : ${responseJson}");
    return responseJson;
  }

  static Future getPostApiResponseData(String url, dynamic body) async {
    dynamic responseJson;
    try {
      dynamic header = {'Content-Type': 'application/json'};
      body = jsonEncode(body);
      Response response =
          await post(Uri.parse(url), body: body, headers: header);
      responseJson = returnResponse(response);
      // print(response.statusCode);
    } on SocketException {
      // print("internet connection lost");
      return {"message": "internet connection lost"};
    } catch (error) {
      // print("error : $error");
      return {"message": error.toString()};
    }
    // print("response : ${responseJson}");
    return responseJson;
  }

  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        return {"message": "Invalid credentials"};
      // throw BadRequestException(response.body.toString());
      case 401:
        return {"message": "Invalid request"};
      // throw BadRequestException(response.body.toString());
      default:
        // print("response : ${response.body}");
        return {"message": "Error Occured while communicating with server"};
      // print(
      //     "Error Occured while communicating with server: ${response.statusCode.toString()}");
    }
  }
}
