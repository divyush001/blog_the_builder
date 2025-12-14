import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.agent.ai/v1/",
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: "application/json",
        //headers: {"Host": "api.agent.ai"},
        validateStatus: (status) => true,
      ),
    );

    // -------------------------------------------------------------------------
    // 🔐 Auth Interceptor — automatically attach access token
    // -------------------------------------------------------------------------
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // final access = await TokenStorage.getAccessToken();
          // if (access != null && access.isNotEmpty) {
          //   options.headers["Authorization"] = "Bearer $access";
          // }
          //options.headers["Accept"] = "*/*";
          //options.headers["content-type"] = "multipart/form-data";
          options.headers["Host"] = "api.agent.ai";
          return handler.next(options);
        },

        // onError: (error, handler) async {
        //   // Handle 401 Unauthorized → Try refreshing token
        //   if (error.response?.statusCode == 401 &&
        //       !error.requestOptions.path.contains("/auth/login") &&
        //       !error.requestOptions.path.contains("/auth/token/refresh")) {
        //     final refreshed = await _refreshToken();
        //     if (refreshed) {
        //       final newAccess = await TokenStorage.getAccessToken();
        //       error.requestOptions.headers["Authorization"] =
        //           "Bearer $newAccess";
        //       final cloneReq = await dio.fetch(error.requestOptions);
        //       return handler.resolve(cloneReq);
        //     } else {
        //       await TokenStorage.clearTokens();
        //     }
        //   }
        //   return handler.next(error);
        // },
      ),
    );

    // -------------------------------------------------------------------------
    // 🧠 Log Interceptor — show full request/response in debug console
    // -------------------------------------------------------------------------
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        error: true,
      ),
    );
  }
}
