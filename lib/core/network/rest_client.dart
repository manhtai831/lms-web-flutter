import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:web_lms/model/answer.dart';
import 'package:web_lms/model/answer.dart';
import 'package:web_lms/model/answer.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/class_model.dart';
import 'package:web_lms/model/department.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/file_folder.dart';
import 'package:web_lms/model/file_student.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/model/file_system.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:web_lms/model/group_role.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/group_type.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/model/question.dart';
import 'package:web_lms/model/repository.dart';
import 'package:web_lms/model/semester.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/subject.dart';
import 'package:web_lms/model/subject.dart';
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

  ///Subject ------------------------------
  @POST("api/create_subject")
  Future<BaseResponse?> createSubject(@Body() Subject o);

  @GET("api/get_subjects")
  Future<BaseResponse?> getListSubject();

  @GET("api/get_subjects")
  Future<BaseResponse?> getListSubjectSearch(@Queries() Map<String, dynamic> m);

  @POST("api/update_subjects")
  Future<BaseResponse?> updateSubject(@Body() Subject o);

  @POST("api/delete_subjects")
  Future<BaseResponse?> deleteSubject(@Body() Subject o);

  ///Role ------------------------------
  @POST("api/create_group")
  Future<BaseResponse?> createGroup(@Body() GroupRole o);

  @GET("api/get_groups")
  Future<BaseResponse?> getListGroup();

  @POST("api/update_group")
  Future<BaseResponse?> updateGroup(@Body() GroupRole o);

  @POST("api/delete_group")
  Future<BaseResponse?> deleteGroup(@Body() GroupRole o);

  @POST("api/get_all_role")
  Future<BaseResponse?> getListRole({@Body() List<int>? l});

  ///Class ------------------------------
  @POST("api/create_class")
  Future<BaseResponse?> createClass(@Body() ClassModel o);

  @GET("api/get_all_class")
  Future<BaseResponse?> getListClass({@Queries() Map<String, dynamic>? m});

  @GET("api/detail_class")
  Future<BaseResponse?> getDetailClass({@Queries() Map<String, dynamic>? m});

  @POST("api/update_class")
  Future<BaseResponse?> updateClass(@Body() ClassModel o);

  @POST("api/delete_class")
  Future<BaseResponse?> deleteClass(@Body() ClassModel o);

  ///Document Type ------------------------------
  @POST("api/create_document_type")
  Future<BaseResponse?> createFileFolder(@Body() FileFolder o);

  @GET("api/get_document_types")
  Future<BaseResponse?> getListFileFolder({@Queries() Map<String, dynamic>? m});

  @GET("api/detail_document_types")
  Future<BaseResponse?> getDetailFileFolder(
      {@Queries() Map<String, dynamic>? m});

  @POST("api/update_document_types")
  Future<BaseResponse?> updateFileFolder(@Body() FileFolder o);

  @POST("api/delete_document_types")
  Future<BaseResponse?> deleteFileFolder(@Body() FileFolder o);

  ///Group Type ------------------------------
  @POST("api/create_group_type")
  Future<BaseResponse?> createGroupType(@Body() GroupType o);

  @GET("api/get_group_types")
  Future<BaseResponse?> getListGroupType({@Queries() Map<String, dynamic>? m});

  @POST("api/update_group_type")
  Future<BaseResponse?> updateGroupType(@Body() GroupType o);

  @POST("api/delete_group_type")
  Future<BaseResponse?> deleteGroupType(@Body() GroupType o);

  ///File system ------------------------------
  @POST("api/create_file_system")
  Future<BaseResponse?> createFileSystem(@Body() FileSystem o);

  @GET("api/get_file_system")
  Future<BaseResponse?> getListFileSystem({@Queries() Map<String, dynamic>? m});

  @POST("api/update_file_system")
  Future<BaseResponse?> updateFileSystem(@Body() FileSystem o);

  @POST("api/delete_file_system")
  Future<BaseResponse?> deleteFileSystem(@Body() FileSystem o);

  ///File student ------------------------------
  @POST("api/create_file_attach")
  Future<BaseResponse?> createFileStudent(@Body() FileStudent o);

  @GET("api/get_list_file_attach")
  Future<BaseResponse?> getListFileStudent(
      {@Queries() Map<String, dynamic>? m});

  @GET("api/detail_file_attach")
  Future<BaseResponse?> getDetailFileStudent(
      {@Queries() Map<String, dynamic>? m});

  @POST("api/update_file_attach")
  Future<BaseResponse?> updateFileStudent(@Body() FileStudent o);

  @POST("api/delete_file_attach")
  Future<BaseResponse?> deleteFileStudent(@Body() FileStudent o);

  ///Question ------------------------------
  @POST("api/create_questions")
  Future<BaseResponse?> createQuestion(@Body() Question o);

  @GET("api/get_all_questions")
  Future<BaseResponse?> getListQuestion({@Queries() Map<String, dynamic>? m});

  @GET("api/getAllQuestionsQuick")
  Future<BaseResponse?> getAllQuestionsQuick(
      {@Queries() Map<String, dynamic>? m});

  @GET("api/list_question_by_type")
  Future<BaseResponse?> getAllQuestionsByType(
      {@Queries() Map<String, dynamic>? m});

  @POST("api/update_questions")
  Future<BaseResponse?> updateQuestion(@Body() Question o);

  @POST("api/delete_questions")
  Future<BaseResponse?> deleteQuestion(@Body() Question o);

  ///Question ------------------------------
  @POST("api/create_answer")
  Future<BaseResponse?> createAnswer(@Body() Answer o);

  @GET("api/get_all_answers")
  Future<BaseResponse?> getListAnswer({@Queries() Map<String, dynamic>? m});

  @POST("api/update_answers")
  Future<BaseResponse?> updateAnswer(@Body() Answer o);

  @POST("api/delete_answers")
  Future<BaseResponse?> deleteAnswer(@Body() Answer o);
}
