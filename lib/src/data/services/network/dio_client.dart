import 'package:crud_app/src/data/models/account/token_model.dart';
import 'package:crud_app/src/data/models/base_response.dart';
import 'package:crud_app/src/data/models/product/category_model.dart';
import 'package:crud_app/src/data/models/product/products_response.dart';
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
  Future<ProductsResponse> getProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
    @Query('keyword') String? search,
    @Query('category_id') int? categoryId,
  });

  @GET('/categories')
  Future<BaseListResponse<CategoryModel>> getCategories();
}
