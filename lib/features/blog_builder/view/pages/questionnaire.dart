import 'package:blog_the_builder/features/blog_builder/view/pages/blog_page.dart';
import 'package:blog_the_builder/domain/model/blog_request.dart';
import 'package:blog_the_builder/features/blog_builder/viewmodel/bloc/blog_bloc.dart';
import 'package:blog_the_builder/features/settings/view/pages/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final TextEditingController topicCtrl = TextEditingController();
  final TextEditingController numCtrl = TextEditingController();
  final TextEditingController nicheCtrl = TextEditingController();
  final TextEditingController url1Ctrl = TextEditingController();
  final TextEditingController url2Ctrl = TextEditingController();
  final TextEditingController url3Ctrl = TextEditingController();

  @override
  void dispose() {
    topicCtrl.dispose();
    numCtrl.dispose();
    nicheCtrl.dispose();
    url1Ctrl.dispose();
    url2Ctrl.dispose();
    url3Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                Navigator.of(context).push<void>(SettingsPage.route()),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Blog generated successfully!')),
            );
            Navigator.of(
              context,
            ).push(BlogPage.route(state.response.toString()));
          } else if (state is BlogFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Please fill the questionnaire to generate your blog",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: topicCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Blog Title",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: numCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Number of Words (max 400)",
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && int.tryParse(value) != null) {
                      if (int.parse(value) > 400) {
                        numCtrl.text = '400';
                      }
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nicheCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter the niche of target audience",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: url1Ctrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter outward link website 1*",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: url2Ctrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter outward link website 2*",
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: url3Ctrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter outward link website 3*",
                  ),
                ),
                const SizedBox(height: 10),
                if (state is BlogLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      final request = BlogRequest(
                        blogTheBuilderTopic: topicCtrl.text,
                        blogTheBuilderNoofwords:
                            int.tryParse(numCtrl.text) ?? 300,
                        blogTheBuilderNiche: nicheCtrl.text,
                        blogTheBuilderUrl1: url1Ctrl.text,
                        blogTheBuilderUrl2: url2Ctrl.text,
                        blogTheBuilderUrl3: url3Ctrl.text,
                      );
                      context.read<BlogBloc>().add(CreateBlogEvent(request));
                    },
                    child: const Text("Generate Blog"),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
