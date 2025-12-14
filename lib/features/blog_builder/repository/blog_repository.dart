import 'package:blog_the_builder/domain/model/blog_request.dart';
import 'package:blog_the_builder/domain/model/blog_response.dart';
import 'package:blog_the_builder/features/blog_builder/service/blog_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BlogRepository {
  final BlogService blogService;

  BlogRepository({required this.blogService});

  Future<Response> createBlog(BlogRequest blogRequest) async {
    return await blogService.createBlog(blogRequest);
  }

  Future<BlogResponse> getBlog(String runId) async {
    debugPrint("Blog runId: $runId");
    final response = await blogService.getBlog(runId);
    debugPrint("Blog response: ${response.toString()}");
    if (response.data == null || response.data is! Map<String, dynamic>) {
      throw Exception("Invalid response from server: ${response.data}");
    }
    final blogResponse = BlogResponse.fromJson(response.data);
    return blogResponse;
  }
}
