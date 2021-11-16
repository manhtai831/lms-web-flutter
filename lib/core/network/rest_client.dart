import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:web_lms/model/department.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/model/semester.dart';
import 'package:web_lms/model/user.dart';

import 'base_response.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  ///User ------------------------------
  @POST("api/login")
  Future<BaseResponse?> login(@Body() User o);

  @POST("api/register")
  Future<BaseResponse?> register(@Body() User o);

  @GET("api/list_user")
  Future<BaseResponse?> getListUser();

  @GET("api/info_user")
  Future<BaseResponse?> getInfoUser();

  @GET("api/list_user")
  Future<BaseResponse?> getListUserSearch(@Queries() Map<String, dynamic> m);

  @POST("api/delete_user")
  Future<BaseResponse?> deleteUser(@Body() User o);

  @POST("api/reset_password")
  Future<BaseResponse?> resetPassword(@Body() User o);

  @POST("api/update_user")
  Future<BaseResponse?> updateUser(@Body() User o);

  ///Repository ------------------------------
  @GET("api/get_repository")
  Future<BaseResponse?> getListRepository();

  @GET("api/get_repository")
  Future<BaseResponse?> getListRepositorySearch(
      @Queries() Map<String, dynamic> m);

  @POST("api/delete_repository")
  Future<BaseResponse?> deleteRepository(@Body() Repository o);

  @POST("api/update_repository")
  Future<BaseResponse?> updateRepository(@Body() Repository o);

  @POST("api/create_repository")
  Future<BaseResponse?> createRepository(@Body() Repository o);

  ///Semester ------------------------------
  @POST("api/create_semester")
  Future<BaseResponse?> createSemester(@Body() Semester o);

  @GET("api/get_semester")
  Future<BaseResponse?> getListSemester();

  @GET("api/get_semester")
  Future<BaseResponse?> getListSemesterSearch(
      @Queries() Map<String, dynamic> m);

  @POST("api/update_semester")
  Future<BaseResponse?> updateSemester(@Body() Semester o);

  @POST("api/delete_semester")
  Future<BaseResponse?> deleteSemester(@Body() Semester o);

  ///Department ------------------------------
  @POST("api/create_department")
  Future<BaseResponse?> createDepartment(@Body() Department o);

  @GET("api/get_all_department")
  Future<BaseResponse?> getListDepartment();

  @GET("api/get_all_department")
  Future<BaseResponse?> getListDepartmentSearch(
      @Queries() Map<String, dynamic> m);

  @POST("api/update_department")
  Future<BaseResponse?> updateDepartment(@Body() Department o);

  @POST("api/delete_department")
  Future<BaseResponse?> deleteDepartment(@Body() Department o);
}
