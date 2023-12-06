import 'package:dartz/dartz.dart';
import 'package:flutter_course/core/error/exceptions.dart';
import 'package:flutter_course/core/error/failures.dart';
import 'package:flutter_course/data_source/remore_weather_datasource.dart';
import 'package:flutter_course/models/weather_model.dart';

class WeatherRepository {
  final RemoteWeatherDataSource remoteWeatherDataSource =
      RemoteWeatherDataSource();

  Future<Either<Failure, WeatherModel>> getCurrentWeatherByName(
      List<String> names) async {
    try {
      final res = await remoteWeatherDataSource.getWeatherByName(names);
      return Right(res);
    } on AuthServerException {
      return Left(ServerFailure(message: "Błędny access token"));
    } on ServerException {
      return Left(ServerFailure(
          message: "Nie znaleziono takiego miejsca, spróbuj jeszcze raz"));
    } on ConnectionException {
      return Left(ConnectionFailure(message: "Brak internetu wariacie!"));
    }
  }
}
