/// Code Written by: Bikram Aryal
// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../common/constants.dart';
import '../common/tools.dart';
import '../config/config.dart';
import '../locator.dart';
import 'authentication_service.dart';
import 'storage_service.dart';

Future<Dio> getDioInstance({bool withAccessToken = true}) async {
  StorageService _storageService = locator<StorageService>();

  Object accessToken =
      (await _storageService.readValueFromSecureStorage(ACCESS_TOKEN_KEY));

  Object refreshToken =
      (await _storageService.readValueFromSecureStorage(REFRESH_TOKEN_KEY));
  Dio client;

  print('this is api url ${locator<IConfig>().apiBaseUrl}');

  AuthenticationService authenticationService =
      locator<AuthenticationService>();

  Dio tokenDIO = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      baseUrl: locator<IConfig>().apiBaseUrl ?? '',
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
    ),
  );

  client = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      "Authorization": "Bearer $accessToken"
    },
    baseUrl: locator<IConfig>().apiBaseUrl ?? '',
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ))
    ..interceptors.addAll([
      InterceptorsWrapper(
        onError: (error, errorInterceptorHandler) {
          if (error.type == DioExceptionType.badResponse) {
            if (error.response!.statusCode == 402) {
              //
              if (error.requestOptions.path == "/programs" ||
                  error.requestOptions.path == "/userQuestionsLogs") {
              } else {
                // Get.to(WorkoutRedirect());
              }
            }

            if (error.response!.statusCode == 401) {
              // debugger();

              if (error.requestOptions.path != '/questions/random/question') {
                Tools.showErrorToast('Session Expired! Please Login Again');

                return;

                // Tools.showLoadingModal();

                // authenticationService.logout().then((value) {
                //   Get.offAll(LoginScreen());
                //   Tools.dismissLoadingModal();
                // }).catchError((err) {
                //   Tools.dismissLoadingModal();
                // });
              }
            }
          }

          if (error.type == DioExceptionType.connectionError) {
            throw error;
          }
          // else if (error.type == DioErrorType.connectTimeout ||
          //     error.type == DioErrorType.receiveTimeout) {
          //   return Tools.showErrorToast('No internet Connection');
          // }
        },
        // onRequest: (request, requestInterceptorHandler) {
        //   print("${request.method} | ${request.path}");
        // }, onResponse: (response, responseInterceptorHandler) {
        //   if (response.statusCode == 402) {
        //     BuildContext context;
        //     return Tools.subscriptionDialog(context);
        //   }
        //   // print('${response.statusCode} ${response.statusCode} ${response.data}');
        // }
      ),
      // customization
      PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90)
//       InterceptorsWrapper(onError: (DioError error) async {
//         if (error.response?.statusCode == 401) {
//           // return error;
//           RequestOptions options = error.request;
//           print("THIS IS OPTIONS ${options.headers}");

// //          ();

//           client.lock();
//           client.interceptors.responseLock.lock();
//           client.interceptors.errorLock.lock();

//           return tokenDIO.post('/auth/refresh-token',
//               data: {
//                 "refresh-token": refreshToken
//               }).then((newToken) async {
//             String newAccessToken = newToken.data['token'];
//             String newRefreshToken =
//                 newToken.data['refreshToken'];

//             print("NEW ACCESS TOKEN $newAccessToken");
//             print("NEW REFRESH TOKEN $newRefreshToken");

//             // Write values to secure storage
//             await _storageService.writeValueToSecureStorage(
//                 ACCESS_TOKEN_KEY, newAccessToken);
//             await _storageService.writeValueToSecureStorage(
//                 REFRESH_TOKEN_KEY, newRefreshToken);

//             accessToken = newAccessToken;
//             refreshToken = newRefreshToken;

//             client.options.headers["Authorization"] =
//                 "Bearer $accessToken";
//           }).whenComplete(() {
//             client.unlock();
//             client.interceptors.responseLock.unlock();
//             client.interceptors.errorLock.unlock();
//           }).then((value) {
//             return client.request(options.path,
//                 options: RequestOptions(headers: {
//                   "Authorization": "Bearer $accessToken"
//                 }));
//           }).catchError((e) {
//             print("DIO error ${e.toString()}");

//             _storageService.logout().then((_) {
//               Get.offAll(LoginScreen());
//             });
//           });
//         }
//         return error;
//       })
    ]);

  return client;
}
