import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'network_util.dart';

part 'dio_client.g.dart';

@RestApi()
abstract class DioClient {
  factory DioClient(Dio dio, {String baseUrl}) = _DioClient;

  static final DioClient instance = _DioClient(NetworkUtil.dio);

  @POST('/auth/login')
  Future<dynamic> login(
    @Body() Map<String, dynamic> body,
  );

  @POST('/auth/register')
  Future<dynamic> register(
    @Body() Map<String, dynamic> body,
  );

  @GET('/user/profile')
  Future<dynamic> getUserProfile();

  @PUT('/user/profile')
  Future<dynamic> updateProfile(
    @Body() Map<String, dynamic> updateData,
  );

  @GET('/items')
  Future<dynamic> getItems(
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('search') String? search,
  );

  @DELETE('/items/{id}')
  Future<dynamic> deleteItem(
    @Path('id') String itemId,
  );
}
