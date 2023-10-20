

import 'package:foodpanda_ui_clone/data/network/api_services.dart';
import 'package:foodpanda_ui_clone/models/response/cuisine_model.dart';
import 'package:foodpanda_ui_clone/res/app_url.dart';
import 'package:foodpanda_ui_clone/views/home/widgets/cuisine.dart';
class CuisineRepository {
  final _apiService = ApiService();
  Future<dynamic>getAllCuisine() async{
    try{
      dynamic responses = await _apiService.getApiResponse(AppUrl.getAllCuisine);
     // print("respone in model: ${ CuisinesModel.fromJson(responses)}");
      return CuisinesModel.fromJson(responses);
    }catch (e){
      rethrow;
    }
  }
}