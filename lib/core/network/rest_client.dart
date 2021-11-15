import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:web_lms/model/user.dart';

import 'base_response.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("api/login")
  Future<BaseResponse?> login(@Body() User o);

  @GET("api/list_user")
  Future<BaseResponse?> getListUser();

  @POST("api/delete_user")
  Future<BaseResponse?> deleteUser(@Body() User o);

 @POST("api/reset_password")
  Future<BaseResponse?> resetPassword(@Body() User o);
}
