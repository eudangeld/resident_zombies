import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class AppRequest {
  final String serviceUri;
  final BaseOptions options;
  AppRequest({
    @required this.serviceUri,
    @required this.options,
  });

  Future<Response> call();

  dynamic prepare();

  bool validate();
}
