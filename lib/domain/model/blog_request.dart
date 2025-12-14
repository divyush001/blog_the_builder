class BlogRequest {
  final String blogTheBuilderTopic;
  final int blogTheBuilderNoofwords;
  final String blogTheBuilderNiche;
  final String blogTheBuilderUrl1;
  final String blogTheBuilderUrl2;
  final String blogTheBuilderUrl3;

  BlogRequest({
    required this.blogTheBuilderTopic,
    required this.blogTheBuilderNoofwords,
    required this.blogTheBuilderNiche,
    required this.blogTheBuilderUrl1,
    required this.blogTheBuilderUrl2,
    required this.blogTheBuilderUrl3,
  });

  Map<String, dynamic> toJson() => {
    "blog_the_builder_topic": blogTheBuilderTopic,
    "blog_the_builder_noofwords": blogTheBuilderNoofwords,
    "blog_the_builder_niche": blogTheBuilderNiche,
    "blog_the_builder_url1": blogTheBuilderUrl1,
    "blog_the_builder_url2": blogTheBuilderUrl2,
    "blog_the_builder_url3": blogTheBuilderUrl3,
  };
}
