import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:web_lms/core/resource/string_resource.dart';
import 'rest_client.dart';

class NetworkUtils {
  static String baseUrl = "http://192.168.1.26:3001/";
  // static String baseUrl = "http://192.168.1.39:3001/";
  // static String baseUrl = "https://lms-app-281.herokuapp.com/";

  static String getBaseUrl() {
    return baseUrl;
  }

  static RestClient? client;

  static Future<RestClient> getClientInstance({String? baseUrl}) async {
    Dio dio = await NetworkUtils.getDioClientToken(baseUrl: baseUrl);
    client ??= RestClient(dio);
    return client!;
  }

  static Future<Dio> getDioClientToken({String? baseUrl}) async {
    final Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? getBaseUrl(),
        contentType: "application/json",
        sendTimeout: 10000,
        connectTimeout: 60000,
        receiveTimeout: 10000,
        receiveDataWhenStatusError: true,
        headers: <String, dynamic>{
          "token": StringResource.token,
        })); // Provide a dio instance
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );
    return dio;
  }

/*static Future<bool> hasConnection() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }*/
}
