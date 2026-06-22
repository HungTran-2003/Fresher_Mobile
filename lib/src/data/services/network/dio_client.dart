import 'package:crud_app/src/data/models/account/token_model.dart';
import 'package:crud_app/src/data/models/base_response.dart';
import 'package:crud_app/src/data/models/product/category_model.dart';
import 'package:crud_app/src/data/models/product/product_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'network_util.dart';

part 'dio_client.g.dart';

@RestApi()
abstract class DioClient {
  factory DioClient(Dio dio, {String baseUrl}) = _DioClient;

  static final DioClient instance = _DioClient(NetworkUtil.dio);

  @POST('/login')
  Future<BaseResponse<TokenModel>> login(
    @Body() Map<String, dynamic> body,
  );

  @POST('/auth/register')
  Future<dynamic> register(
    @Body() Map<String, dynamic> body,
  );

  @GET('/products')
  Future<BaseListResponse<ProductModel>> getProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
    @Query('keyword') String? search,
    @Query('category_id') int? categoryId,
  });

  @GET('/categories')
  Future<BaseListResponse<CategoryModel>> getCategories();

  @POST('/products')
  Future<dynamic> addProduct(
    @Body() Map<String, dynamic> body,
  );

  @PUT('/products/{id}')
  Future<dynamic> updateProduct(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/products/{id}')
  Future<dynamic> deleteProduct(
    @Path('id') int id,
  );
}
