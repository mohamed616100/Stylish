import 'package:dartz/dartz.dart';
import 'package:stylish/featuers/items/data/models/categorie_model.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/app_endpoint.dart';
class CategorieRepo{
  ApiHelper apiHelper =ApiHelper();
  Future<Either<String, CategorieModel>> getsProduct() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.getMenu,
          isProtected: true,
      );
      if(response.status)
      {
        CategorieModel categorieModel= CategorieModel.fromJson(response.data);
        return Right(categorieModel);
      }
      else
      {
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}