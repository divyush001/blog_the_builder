class BlogResponse {
  //final String runId;
  final String status;
  final String response;

  BlogResponse({
    //required this.runId,
    required this.status,
    required this.response,
  });

  factory BlogResponse.fromJson(Map<String, dynamic> json) {
    return BlogResponse(
      //runId: json['run_id'],
      status: json['status'],
      response: json['response'],
    );
  }
}
