import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState._({this.data, this.error});

}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super._(data: data);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(DioException error) : super._(error: error);
}