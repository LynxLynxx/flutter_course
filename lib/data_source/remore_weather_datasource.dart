import 'package:dio/dio.dart';
import 'package:flutter_course/constants/api_k.dart';
import 'package:flutter_course/core/error/exceptions.dart';
import 'package:flutter_course/models/weather_model.dart';

class RemoteWeatherDataSource {
  final Dio dio = Dio();

  Future<WeatherModel> getWeatherByName(List<String> names) async {
    try {
      final response = await dio.get(ApiK.currentWeatherByName(names), options: Options(validateStatus: (_)=>true));
      if (response.statusCode==200) {
        return WeatherModel.fromJson(response.data);
      } else if (response.statusCode==401) {
        throw AuthServerException();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthServerException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ConnectionException();
    }
  }
}
