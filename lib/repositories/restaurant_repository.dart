
import 'package:foodpanda_ui_clone/data/network/api_services.dart';
import 'package:foodpanda_ui_clone/models/response/restaurant_model.dart';
import 'package:foodpanda_ui_clone/res/app_url.dart';

class RestaurantRepository{
  final _apiService = ApiService();
  Future<RestaurantModel>getRestaurants() async{
    try{
      dynamic responses = await _apiService.getApiResponse(AppUrl.getAllRestaurant);
      //print('response ${responses["data"][0]["attributes"]["name"]}');
     // print("respone in model: ${ RestaurantModel.fromJson(responses)}");
      return RestaurantModel.fromJson(responses);
    }catch (e){
      rethrow;
    }
  }
}