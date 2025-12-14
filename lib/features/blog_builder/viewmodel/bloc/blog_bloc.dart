import 'package:blog_the_builder/domain/model/blog_response.dart';
import 'package:blog_the_builder/features/blog_builder/repository/blog_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:blog_the_builder/domain/model/blog_request.dart';
import 'package:dio/dio.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository blogRepository;

  BlogBloc({required this.blogRepository}) : super(BlogInitial()) {
    on<CreateBlogEvent>((event, emit) async {
      debugPrint("Blog event: ${event.blogRequest}");
      emit(BlogLoading());
      try {
        debugPrint("Blog request: ${event.blogRequest.toJson()}");
        final createResponse = await blogRepository.createBlog(
          event.blogRequest,
        );
        debugPrint("Create response: ${createResponse.data}");
        final runId = createResponse.data['run_id'];
        debugPrint("Run ID: $runId");
        if (runId == null) {
          emit(BlogFailure("Failed to get run_id"));
          return;
        }

        // Poll for status
        BlogResponse? blogResponse;
        dynamic status = "pending";
        int attempts = 0;
        const maxAttempts = 30; // Timeout after 60 seconds

        while (status != 200 && attempts < maxAttempts) {
          await Future.delayed(const Duration(seconds: 10));
          blogResponse = await blogRepository.getBlog(runId);
          status = blogResponse.status;
          attempts++;
          debugPrint("Blog status: $status");
        }

        if (status == 200 && blogResponse != null) {
          debugPrint("Blog status: $status");
          debugPrint("Blog generated successfully");
          debugPrint(blogResponse.response.toString());
          emit(BlogSuccess(blogResponse));
        } else {
          debugPrint("Blog status: $status");
          emit(
            BlogFailure("Blog generation failed or timed out. Status: $status"),
          );
        }
      } catch (e) {
        emit(BlogFailure(e.toString()));
      }
    });
  }
}
