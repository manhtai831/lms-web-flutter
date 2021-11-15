import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:web_lms/core/resource/string_resource.dart';
import 'rest_client.dart';

class NetworkUtils {
  static String baseUrl = "http://192.168.1.39:3000/";

  static String getBaseUrl() {
    return baseUrl;
  }

  static RestClient? client;

  static Future<RestClient> getClientInstance() async {
    Dio dio = await NetworkUtils.getDioClientToken();
    client ??= RestClient(dio);
    return client!;
  }

  static Future<Dio> getDioClientToken() async {
    final Dio dio = Dio(BaseOptions(
        baseUrl: getBaseUrl(),
        contentType: "application/json",
        sendTimeout: 60000,
        connectTimeout: 60000,
        receiveTimeout: 60000,
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
