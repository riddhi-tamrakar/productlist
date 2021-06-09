import 'dart:convert';
import 'package:app/src/overrides.dart';
import 'package:http/http.dart' as httpClient;
import 'db_service_response.model.dart';

class DbServices {
  getapi(api, {headers}) async {
    try {
      final response = await httpClient.get(
        Uri.parse('${Overrides.API_BASE_URL}$api'),
        headers:
            headers != null ? headers : {'Content-Type': 'application/json'},
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        return ResponseModel(statusCode: response.statusCode, data: data);
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw ('NO_CONNECTION');
      } else {
        throw (e);
      }
    }
  }

  postapi(api, {body, headers}) async {
    try {
      final response = await httpClient.post(
          Uri.parse('${Overrides.API_BASE_URL}$api?output=json'),
          headers: headers ?? {'Content-Type': 'application/json'},
          body: json.encode(body));
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(statusCode: response.statusCode, data: data);
      } else {
        return ResponseModel(statusCode: response.statusCode, data: data);
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup')) {
        throw ('No Internet connection');
      } else {
        throw (e);
      }
    }
  }
}
