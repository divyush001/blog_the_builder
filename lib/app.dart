import 'package:blog_the_builder/features/blog_builder/repository/blog_repository.dart';
import 'package:blog_the_builder/features/blog_builder/service/blog_service.dart';
import 'package:blog_the_builder/features/blog_builder/view/pages/questionnaire.dart';
import 'package:blog_the_builder/features/blog_builder/viewmodel/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlogBloc>(
          create: (BuildContext context) => BlogBloc(
            blogRepository: BlogRepository(blogService: BlogService()),
          ),
        ),
      ],
      child: MaterialApp(home: const Questionnaire()),
    );
  }
}
