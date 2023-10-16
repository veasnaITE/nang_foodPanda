

import 'package:foodpanda_ui_clone/data/network/api_services.dart';
import 'package:foodpanda_ui_clone/res/app_url.dart';
import 'package:foodpanda_ui_clone/views/home/model/cuisines.dart';

class CuisineRepository {
  final _apiService = ApiService();
  Future<CuisinesModel>getAllCuisine() async{
    try{
      dynamic responses = await _apiService.getApiResponse(AppUrl.getAllCuisine);
     // print("respone in model: ${ CuisinesModel.fromJson(responses)}");
      return CuisinesModel.fromJson(responses);
    }catch (e){
      rethrow;
    }
  }
}