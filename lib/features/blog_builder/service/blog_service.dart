import 'package:blog_the_builder/domain/model/blog_request.dart';
import 'package:blog_the_builder/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BlogService {
  late final _dio = DioClient().dio;

  Future<Response> createBlog(BlogRequest blogRequest) async {
    return await _dio.post(
      "agent/0du2oazzzj96lzgr/webhook/d662cf69/async",
      data: blogRequest.toJson(),
    );
  }

  Future<Response> getBlog(String runId) async {
    final response = await _dio.get(
      "agent/0du2oazzzj96lzgr/webhook/d662cf69/status/$runId",
    );
    debugPrint("Blog response at service: $runId");
    debugPrint(
      "url called: ${_dio.options.baseUrl} + agent/0du2oazzzj96lzgr/webhook/d662cf69/status/$runId",
    );
    debugPrint("Blog response at service: ${response.data}");
    debugPrint("Blog response at service: ${response.toString()}");
    return response;
  }
}
