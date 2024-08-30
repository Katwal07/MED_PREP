// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:http_parser/http_parser.dart' as parser;
import 'package:mime/mime.dart';
import '../common/constants.dart';
import '../common/tools.dart';
import '../config/config.dart';
import '../locator.dart';
import '../models/app_config.dart';
import '../models/chapter.dart';
import '../models/exam.dart';
import '../models/message.dart';
import '../models/my_stat.dart';
import '../models/notification.dart';
import '../models/packages.dart';
import '../models/payment.dart';
import '../models/porgram.dart';
import '../models/question.dart';
import '../models/question_stat.dart';
import '../models/result.dart';
import '../models/section.dart';
import '../models/topic.dart';
import '../models/treasures.dart';
import '../models/user.dart';
import '../tabbar.dart';
import '../ui/screens/login/login_screen.dart';
import 'dio_instance.dart';
import 'storage_service.dart';

class Api {
  var client = new Dio();

  final apiEndpoint = locator<IConfig>().apiBaseUrl;

  StorageService _storageService = locator<StorageService>();

  // Get List of Question Based on Filters
  Future<Result> getListOfQuestions({
    required Map<String, dynamic> queryParameters,
  }) async {
    final dioInstance = await getDioInstance();
    // debugger();

    try {
      // debugger();
      final res = await dioInstance.post(
        '/app/results',
        queryParameters: queryParameters,
      );

      // debugger();

      printLog('GET /app/results Successfully');

      if (res.statusCode == 200) {
        final resultId = res.data['data']['id'];
        final storedResultId =
            await _storageService.readValueFromSecureStorage(RESULT_ID);
        if (storedResultId == null || storedResultId != resultId) {
          await _storageService.writeValueToSecureStorage(RESULT_ID, resultId);
        }

        return Result.fromJson(res.data['data']);
      } else if (res.statusCode == 401) {
        Get.to(() => LoginScreen());
      }
      throw 'Some Error which fetching questions';
    } catch (err) {
      printLog(
          'Failed to Fetch List of Questions. Endpoint: /app/results Error: $err');
      throw err;
    }
  }

  // Post User Stat - For Each Question Submitted.

  Future<void> postUserStat({
    required int timeTaken,
    required String question,
    required String selectedAnswer,
  }) async {
    final dioInstance = await getDioInstance();
    try {
      final storedResultId =
          await _storageService.readValueFromSecureStorage(RESULT_ID);

      final res = await dioInstance.post('/app/userQuestionsLogs', data: {
        "timeTaken": timeTaken,
        "question": question,
        "selectedAnswer": selectedAnswer,
        "result": storedResultId,
      });

      printLog('POST /userQuestionLogs Successfully');

      printLog(res);
    } catch (err) {
      print(
          'Failed to Post Uset Stat. Endpoint: /userQuestionLogs Error: $err');
      throw err;
    }
  }

  // Post  User Result exam/test id.

  Future<ResultList> getUserResults() async {
    final dioInstance = await getDioInstance();

    try {
      final res = await dioInstance.get('/app/results');
      // printLog('GET /app/results/ Successfully');

      print(res);
      return ResultList.fromJson(res.data['data']);
    } catch (err) {
      print('Failed to Get Uset Result. Endpoint: /app/results/ Error: $err');
      throw err;
    }
  }
  // Get Questions Based on Exams

  Future<QuestionList> getQuestionBasedOnExam({
    required String examId,
  }) async {
    final dioInstance = await getDioInstance();
    try {
      final res =
          await dioInstance.post('/app/results', data: {'exam': examId});

      if (res.statusCode == 200) {
        print('GET /app/results Questions Based on Exam Successfully');
        final resultId = res.data['data']['id'];

        final storedResultId =
            await _storageService.readValueFromSecureStorage(RESULT_ID);
        if (storedResultId == null || storedResultId != resultId) {
          await _storageService.writeValueToSecureStorage(RESULT_ID, resultId);
        }

        // Convert the JSON response to Result and extract questions
        final result = Result.fromJson(res.data['data']);
        final questions = result.questionAnswer
                ?.where((e) =>
                    e !=
                    null) // Filter out null values if questionAnswer is not null
                .map((e) => e) // Assert non-null values
                .map((q) => q.question) // Extract the question property
                .toList() ??
            []; // Provide default empty list if null

        final nonNullableQuestions = questions.whereType<Question>().toList();

        return QuestionList(nonNullableQuestions);
      } else {
        print('Failed to fetch questions. Status code: ${res.statusCode}');
        throw Exception('Failed to load questions');
      }
    } catch (err) {
      print(
          'Failed to get questions based on Exam Id. Endpoint: /app/results Error: $err');
      throw err;
    }
  }

//Get Result Based on Exam

  // Get Chapters Based on Section Id

  Future<QuestionList> getResultById({required String id}) async {
    try {
      // debugger();
      final client = await getDioInstance();
      final res = await client.get('/app/results/$id');
      print(res);

      var questionAnswerList =
          res.data['data']['questionAnswer'] as List<dynamic>;

      List<Question> questions = questionAnswerList
          .where((e) => e != null) // Filter out null values
          .map((e) => Question.fromJson(
              e as Map<String, dynamic>)) // Convert each item to Question
          .toList();

      return QuestionList(questions);
    } catch (err) {
      print('GET /app/results/$id Failed.');

      throw err;
    }
  }

// Get Questions Based on result

  // Future<ResultList> getQuestionBasedOnResult({
  //   @required String examId,
  // }) async {
  //   final dioInstance = await getDioInstance();

  //   try {
  //     final res = await dioInstance.get(
  //       '/exams/$examId',
  //     );

  //     print('GET /exams/$examId Questions Based on Exam Successfully');

  //     if (res.statusCode == 200) {
  //       return QuestionList.fromJson(res.data['data']);
  //     }
  //     throw 'Some Error which fetching questions';
  //   } catch (err) {
  //     print(
  //         'Failed get Questions based on Exam Id. Endpoint: /exams/$examId Error: $err');

  //     throw err;
  //   }
  // }

  // Get all Subjects

  Future<dynamic> getAllSubjects() async {
    final dioInstance = await getDioInstance();

    try {
      final res = await dioInstance.get('/questions/getAllSubjects');

      print('GET /questions/getAllSubjects Get All Subjects Successfully');

      if (res.statusCode != 200) {
        throw 'Request was not successful. Responsed retured with status code ${res.statusCode}';
      }

      return res.data;
      // return SubjectList.fromJson(res.data['data']);
    } catch (err) {
      print(
          'Failed to Get All Subjects. Endpoint: /questions/getAllSubjects Error: $err');
      throw err;
    }
  }

  // Get All Available Exams

  Future<ExamListTotal> getAllExams({int page = 1}) async {
    final dioInstance = await getDioInstance();

    try {
      final res = await dioInstance.get('/app/exams?page=$page&limit=5');

      print('GET /examps Get All Exams Successfully');

      if (res.statusCode != 200) {
        throw 'Request was not successful. Responsed retured with status code ${res.statusCode}';
      }
      return ExamListTotal.fromJson(res.data);
    } catch (err) {
      print('Failed to All Examps. Endpoint: /exams Error: $err');
      throw err;
    }
  }

  // Get Random Questions

  Future<Question> getRandomQuestion() async {
    final dioInstance = await getDioInstance();

    Question question;

    try {
      final res = await dioInstance.get('/questions/random/question');

      print('GET /questions/random/question Get All Questions Successfully');

      printLog(res.data);

      question = Question.fromJson(res.data['data']);
    } catch (err) {
      print(
          'Failed to Get Random Question. Endpoint: /questions/random/question Error: $err');
      throw err;
    }
    return question;
  }

  // Update Push Notification to the Server

  Future<void> updatePushNotificationToken(String token) async {
    final dioInstance = await getDioInstance();

    try {
      // Send Patch Request to Me Route.
      final res = await dioInstance
          .patch('/auth/profile', data: {"notificationToken": token});

      printLog(res.data);

      print('PATCH: Successfully Send Notification Token to Server');
    } catch (err) {
      // dev.();
      print(
          'Failed to Update Notification Token. Endpoint: /auth/updateMe Error: $err');
      throw err;
    }
  }

  // Update Enable Notification

  Future<void> updatePushNotification(dynamic preference) async {
    // debugger();
    final dioInstance = await getDioInstance();

    try {
      // Send Patch Request to Me Route.
      final res = await dioInstance
          .patch('/app/auth/profile', data: {"enableNotification": preference});

      printLog(res.data);

      print('PATCH: Successfully Send Notification Token to Server');
    } catch (err) {
      // dev.();
      print(
          'Failed to Update Notification Token. Endpoint: /auth/updateMe Error: $err');
      throw err;
    }
  }

  // Login User

  Future<void> updateUserSelectedProgram(String programId) async {
    final dioInstance = await getDioInstance();

    try {
      // Send Patch Request to Me Route.
      final res = await dioInstance
          .patch('/auth/profile', data: {"selectedProgram": programId});

      printLog(res.data);

      await getMe();

      print('PATCH: Successfully Selected PRogram ID User setting');
    } catch (err) {
      // dev.();
      print(
          'Failed to Update  User program. Endpoint: /auth/profile Error: $err');
      throw err;
    }
  }

Future<User?> login(String email, String password) async {
  try {
    var res = await client.post('$apiEndpoint/auth/signin',
        data: {"email": email, "password": password});
    String token = res.data['accessToken'];
    await _storageService.writeValueToSecureStorage(ACCESS_TOKEN_KEY, token);
    final userIsStored =
        await _storageService.saveUser(jsonEncode(res.data['data']));

    if (userIsStored) {
      printLog('USER HAS BEEN STORED TO SHAREDPREFERENCES');
    }

    printLog('POST: Successfully logged user in');
    return User.fromJson(res.data['data']);
  } catch (err) {
    if (err is DioException) {
      print("errorhere $err");
      if (err.type == DioExceptionType.connectionError) {
        if (err.error is SocketException) {
          Tools.showErrorToast('Socket Exception');
        }
      } else if (err.type == DioExceptionType.badResponse) {
        if (err.response?.data != null && err.response?.data['errors'] != null) {
          String joinedError = (err.response?.data['errors'] as List)
              .map((err) => err['message'] as String)
              .join('||');

          Tools.showErrorToast(joinedError);
        }
      } else if (err.type == DioExceptionType.cancel) {
        Tools.showErrorToast('Request was cancelled');
      }
    }

    return null;
  }
}


  // Sign Up User

Future<User> signup(String name, String email, String password,
    String confirmPassword) async {
  try {
    var res = await client.post('$apiEndpoint/auth/signup', data: {
      "email": email,
      "password": password,
      "name": name,
      "passwordConfirm": confirmPassword
    });

    String token = res.data['accessToken'];
    await _storageService.writeValueToSecureStorage(ACCESS_TOKEN_KEY, token);
    final userIsStored =
        await _storageService.saveUser(jsonEncode(res.data['data']));

    if (userIsStored) {
      printLog('USER HAS BEEN STORED TO SHAREDPREFERENCES');
    }
    printLog('POST: Successfully signed up user');
    return User.fromJson(res.data['data']);
  } catch (err) {
    print("This is error $err");
    
    if (err is DioException) {
      if (err.response != null) {
        Tools.showErrorToast('Sign up attempt was not successful: ${err.response?.statusMessage}');
        throw err.response!;
      } else if (err.type == DioExceptionType.connectionError) {
        Tools.showErrorToast('Network error occurred. Please check your connection.');
      } else if (err.type == DioExceptionType.cancel) {
        Tools.showErrorToast('Sign up request was cancelled');
      } else {
        Tools.showErrorToast('An unexpected error occurred during sign up');
      }
    } else {
      Tools.showErrorToast('An unexpected error occurred during sign up');
    }
      throw err;
  }
}

  // Get My Profile

  Future<User> getMe() async {
    final dioInstance = await getDioInstance();
    try {
      final res = await dioInstance.get(
        '/auth/profile',
      );

      print('GET: Successfully Fetched user profile');

      // if (res.data['data'].isUserVerified) {
      //   Get.offAll(NotVerifiedScreen(
      //     user: res.data['data'],
      //   ));
      // }

      final userIsStored =
          await _storageService.saveUser(jsonEncode(res.data['data']));

      if (userIsStored) {
        printLog('USER HAS BE STORED TO SHAREDPREFERENCES');
      }
      return User.fromGetMeJson(res.data);
    } catch (err) {
      print('Failed to Get User Profile. Endpoint: /auth/profile Error: $err');
      throw err;
    }
  }

  Future<String> uploadMessagePhoto({File? image}) async {
    final dioInstance = await getDioInstance();
      if (image == null) {
    throw ArgumentError('Image file is required');
  }

    String? mimetype = lookupMimeType(image.path);
    String type = mimetype!.split("/")[0];
    String extension = mimetype.split("/")[1];

    try {
      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path,
            contentType: parser.MediaType(type, extension)),
      });

      final res = await dioInstance.post('$apiEndpoint/messages/image-upload',
          data: data);

      if (res.statusCode == 200) {
        String imageUrl = res.data['imageUrl'];

        print(
            'POST /messages/image-upload Uploaded Image Successfully. And the link is $imageUrl');

        return imageUrl;
      }

      throw 'Failed to Upload image';
    } catch (err) {
      print(err);
      throw err;
    }
  }

Future<User?> updateUserProfile({File? image, String? token}) async {
  if (image == null) {
    throw ArgumentError('Image file is required');
  }
  if (token == null) {
    throw ArgumentError('Token is required');
  }

  String? mimetype = lookupMimeType(image.path);
  if (mimetype == null) {
    throw FormatException('Unable to determine MIME type of the image');
  }

  List<String> mimeparts = mimetype.split("/");
  if (mimeparts.length != 2) {
    throw FormatException('Invalid MIME type: $mimetype');
  }

  String type = mimeparts[0];
  String extension = mimeparts[1];

  try {
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path,
          contentType: parser.MediaType(type, extension)),
    });

    final res = await client.post(
      '$apiEndpoint/auth/image-upload',
      data: data,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }, contentType: 'multipart/form-data'),
    );

    if (res.statusCode == 200) {
      String imageUrl = res.data['imageUrl'];
      final updateUser = await client.patch(
        '$apiEndpoint/users/profile',
        data: {"photoUrl": imageUrl},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (updateUser.statusCode == 200) {
        print(
            'PATCH /users/profile Updated User Profile Successfully. Updated user is ${updateUser.data}');
        final userIsStored = await _storageService
            .saveUser(jsonEncode(updateUser.data['data']));

        if (userIsStored) {
          print('USER HAS BEEN STORED TO SHAREDPREFERENCES');
        }
        return User.fromJson(updateUser.data['data']);
      }
    }
    return null;
  } catch (err) {
    if (err is DioException) {
      if (err.response != null) {
        print('Error response data: ${err.response?.data}');
        print('Error response status: ${err.response?.statusCode}');
      } else {
        print('Error without response: ${err.message}');
      }
      //throw err.response ?? err.message;
    } else {
      print('Unexpected error: $err');
      throw err;
    }
  }
  return null;
}

//update user profile picture
  Future<User?> updateUserProfilePicture({
    User? user,
    File? image,
  }) async {
          if (image == null) {
    throw ArgumentError('Image file is required');
  }
    var dioInstance = await getDioInstance();
    String? mimetype = lookupMimeType(image.path);

    String type = mimetype!.split("/")[0];
    String extension = mimetype.split("/")[1];
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path,
          contentType: parser.MediaType(type, extension)),
    });
    // print('This is path of image ' + data as FormData);

    try {
      Response? res;
      if (image != null) {
        res = await dioInstance.post(
          '/auth/image-upload',
          data: data,
        );
        //
      }

      // Patch Request to update user info
      final userPatchRes = await dioInstance
          .patch('/auth/profile', data: {"photoUrl": res!.data['data']});

      if (userPatchRes.statusCode == 200) {
        final userIsStored = await _storageService
            .saveUser(jsonEncode(userPatchRes.data['data']));

        if (userIsStored) {
          print('USER HAS BE STORED TO SHAREDPREFERENCES');
        }
        return User.fromJson(userPatchRes.data);
      }

      return null;
    } on DioException catch (e) {
      print('Error from image upload service $e');
      return null;
    }
  }
  // Fetch Notifications

  Future<NotificationList> fetchNotifications(int page, int limit) async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.get('/app/notifications',
          queryParameters: {"page": page, "limit": limit, 'sort': '-created'});

      if (res.statusCode == 200) {
        printLog('GET: Fetched Notifications successfully');

        final isDataCachedToStorage =
            await _storageService.saveDataToSharedPrefs(
                key: CACHE_NOTIFICATION_KEY, data: jsonEncode(res.data));
        if (isDataCachedToStorage) {
          printLog(
              'SAVE: Saved Notification data in local storage for later use.');
        }
        return NotificationList.fromJson(res.data['data']);
      }
      return NotificationList([]);
    } catch (err) {
      throw err;
    }
  }

  // Fetch More Notifications

  Future<NotificationList> fetchMoreNotifications(int page, int limit) async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.get('/app/notifications',
          queryParameters: {"page": page, "limit": limit});

      if (res.statusCode == 200) {
        print('GET: More Notification was loaded successfully');
        return NotificationList.fromJson(res.data['data']);
      }
      return NotificationList([]);
    } catch (err) {
      throw err;
    }
  }

  // Get Question of the Day

  Future<Question?> getQuestionOfTheDay() async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.get('/questions/random/question');
      // var res = await dioInstance.get('');

      if (res.statusCode == 200) {
        print(
            'GET /questions/random/question Successfully. And the response is ${res.data}');
        return Question.fromJson(res.data['data']);
      }
      return null;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  // Get User Stat

  Future<MyStat?> getMyStat() async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.get(
        '/app/userQuestionsLogs',
      );
      if (res.statusCode == 200) {
        print('GET: User Stat was fetched successfully ${res.data}');

        return MyStat.fromJson(res.data);
      } else if (res.statusCode == 401) {
        Get.to(LoginScreen());
      }
      return null;
    } catch (err) {
      throw err;
    }
  }

  // Forget Password

  Future<bool> forgetPassword({
    required String email,
  }) async {
    try {
      var res = await client.post(
        '$apiEndpoint/auth/forgotPassword',
        data: {
          "email": email,
        },
      );

      if (res.statusCode == 200) {
        print('GET: Email Reset Successful ${res.data}');
        return true;
      }
      return false;
    } catch (err) {
      return false;
    }
  }

  Future<bool> resendEmailVerification() async {
    // debugger();
    final storedToken =
        await _storageService.readValueFromSecureStorage(ACCESS_TOKEN_KEY);

    if (storedToken == null) {
      return false;
    }

    try {
      var res = await client.get('$apiEndpoint/auth/resendtoken',
          options: Options(headers: {'Authorization': 'Bearer $storedToken'}));
      print(res);

      if (res.statusCode == 200) {
        print('POST: Resend Email Confirmation Successful ${res.data}');
        return true;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  // Get Question Stat

  Future<QuestionStat?> getQuestionStat(String id) async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.get(
        '/questionstats/$id',
      );

      if (res.statusCode == 200) {
        print(
            'GET: Successfully Fetched Question Stat For question $id Response: ${res.data}');
        return QuestionStat.fromJson(res.data['data']);
      }
      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }

  // Discussions
  Future<TopicList?> getAllTopics() async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.get(
        '/topics',
      );

      if (res.statusCode == 200) {
        print('GET: Successfully Fetched All Topics Response: ${res.data}');
        return TopicList.fromJson(res.data['data']);
      }
      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }

  Future<bool> createTopic(
      {required String name, String description = ''}) async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.post(
        '/topics',
        data: {'name': name, 'description': description},
      );

      if (res.statusCode == 201) {
        print('POST /topics Successfully. And the response is ${res.data}');
        return true;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  ///Report Question
  Future<bool> reportQuestion(
      {required String id, required String description}) async {
    final dioInstance = await getDioInstance();

    try {
      var res = await dioInstance.post(
        '/app/questions/report',
        data: {'id': id, 'description': description},
      );

      if (res.statusCode == 201) {
        print(
            'POST /app/questions/report Successfully. And the response is ${res.data}');
        return true;
      }
      return false;
    } catch (err) {
      print(err);
      return false;
    }
  }

  ///
  // Get Last Messages
  Future<MessageList> getLastMessages(
      {required String topicId, int page = 1}) async {
    final dioInstance = await getDioInstance();

    print('This is page number $page');

    try {
      var res = await dioInstance.get(
        '/messages',
        queryParameters: {'page': page, 'limit': 20, "topicId": topicId},
      );

      print('There are ${res.data['data'].length}');

      if (res.statusCode == 200) {
        print(
            'GET /messages Last Messages with Limit 20 and Page $page Successfully');
        return MessageList.fromJson(res.data['data']);
      }
      throw 'Failed to fetch messages';
    } catch (err) {
      print(err);
      throw err;
    }
  }
  // Get All Available Sections

  Future<SectionList> getSectionData({String? tags}) async {
    // You will receive a tag (this optional - null)
    StorageService _storageService = locator<StorageService>();
    User user = await _storageService.getUser();
    print(user);

    try {
      final client = await getDioInstance();
      final res = await client.get(
          '/app/sections/filterbyprogram?programId=${user.selectedProgram}');
      print(res);

      if (res.statusCode == 200) {
        print(
            'GET /sections/filterbyprogram?programId=6157bfadac6c010012ce00f9 Successfully.');

        final sectionList = SectionList.fromJson(res.data['data']);

        if (tags == null) {
          return sectionList;
        } else {
          final filteredSections = sectionList.sections
              .where((element) => element.tag == tags)
              .toList();
          return SectionList(filteredSections);
        }
      }

      throw 'Failed to Fetch Sections';
    } catch (err) {
      throw err;
    }
  }

  // Get Chapters Based on Section Id

  Future<ChapterList> getChaptersBySectionId({required String id}) async {
    // debugger();
    try {
      final client = await getDioInstance();
      final res =
          await client.get('/app/chapters/filterbysection?sectionId=$id');

      if (res.statusCode == 200) {
        print('GET /chapters/filterbysection?sectionId=$id Successfully.');

        return ChapterList.fromJson(res.data['data'], res.data['total']);
      }

      print(res);
      throw res;
    } catch (err) {
      print('GET /chapters/filterbysection?sectionId=$id Failed.');

      throw err;
    }
  }

  // Get payment Status
  // Get all Subjects

  Future<PaymentList> getMyPayment() async {
    // You will receive a tag (this optional - null)

    try {
      final client = await getDioInstance();
      final res = await client.get('/payments/getpayments');

      if (res.statusCode == 200) {
        PaymentList result = PaymentList.fromJson(res.data['data']);
        if (result.payments.isNotEmpty) {
          if (result.payments[0].paymentStatus == "success" &&
              DateTime.parse(result.payments[0].dateTo!).millisecondsSinceEpoch >
                  DateTime.now().millisecondsSinceEpoch) {
            await _storageService.setBoolToSharedPrefs(
                data: true, key: PAYMENT_STATUS);
          } else {
            await _storageService.setBoolToSharedPrefs(
                data: false, key: PAYMENT_STATUS);
          }
        } else {
          await _storageService.setBoolToSharedPrefs(
              data: false, key: PAYMENT_STATUS);
        }

        return result;
      }

      throw 'Failed to Fetch Payments';
    } catch (err) {
      throw err;
    }
  }

  Future<PackageList> getMyPackage() async {
    // You will receive a tag (this optional - null)
    try {
      final client = await getDioInstance();
      final res = await client.get('/packages');

      if (res.statusCode == 200) {
        print('GET packages Successfully.');

        return PackageList.fromJson(res.data['data']);
      }

      throw 'Failed to Fetch Package';
    } catch (err) {
      throw err;
    }
  }

  // fetch programs
  Future<ProgramList?> getPrograms() async {
    final dioInstance = await getDioInstance();

    try {
      final res = await dioInstance.get(
        '/app/programs',
      );
      //
      print('GET: Successfully Fetched user profile');

      // final programIsStored = await _storageSere
      //     .saveProgramId(jsonEncode(res.data['data']['id']));

      // if (programIsStored) {
      //   printLog('USER HAS BE STORED TO SHAREDPREFERENCES');
      // }
      return ProgramList.fromJson(res.data['data']);
    } catch (err) {
      print('Failed to Get User Programs. Endpoint: /programs Error: $err');
      return null;
    }
  }

  // Esewa post data
Future<User?> postEsewa({Map<String, dynamic>? paymentResponse}) async {
  try {
    var res = await client.post('$apiEndpoint/esewa', data: paymentResponse);

    printLog('POST: data successfully');
    return User.fromJson(res.data);
  } catch (err) {
    if (err is DioException) {
      if (err.type == DioExceptionType.connectionError) {
        if (err.error is SocketException) {
          Tools.showErrorToast('Socket Exception');
        } else {
          Tools.showErrorToast('Connection error');
        }
      } else if (err.type == DioExceptionType.badResponse) {
        if (err.response?.data != null && err.response?.data['errors'] != null) {
          String joinedError = (err.response?.data['errors'] as List)
              .map((e) => e['message'] as String)
              .join('||');

          Tools.showErrorToast(joinedError);
        } else {
          Tools.showErrorToast('Bad response from server');
        }
      } else {
        Tools.showErrorToast('An error occurred: ${err.message}');
      }
    } else {
      Tools.showErrorToast('An unexpected error occurred');
    }

    print('Error in postEsewa: $err');
    return null;
  }
}

  // manual payment method
  // ignore: missing_return
  Future<Payment?> manualpayment(String paidText, String noteText,
      File imageFile, String packageText, String dateFrom) async {
    final dioInstance = await getDioInstance();
    String? mimetype = lookupMimeType(imageFile.path);
    String type = mimetype!.split("/")[0];
    String extension = mimetype.split("/")[1];
    try {
      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path,
            contentType: parser.MediaType(type, extension)),
      });
      final imageUpload = await dioInstance
          .post('$apiEndpoint/messages/image-upload', data: data);
      var res = await dioInstance.post('$apiEndpoint/payments/manual', data: {
        "paidVia": paidText,
        "description": noteText,
        "image": imageUpload.data['imageUrl'],
        "packageType": packageText,
        'dateFrom': dateFrom,
      });
      if (res.statusCode == 200) {
        return Payment.fromJson(res.data);
      }
      Get.to(MainTabs());
      // return Payment.fromJson(res.data);
      print(res.data);
    } catch (err) {
      if (err is DioException) {
        if (err.type == DioExceptionType.connectionError) {
          if (err.error is SocketException) {
            Tools.showErrorToast('Socket Expection');
          }
        } else {
          if (err.type == DioExceptionType.badResponse) {
            if (err.response?.data != null) {
              if (err.response?.data['errors'] != null &&
                  err.response?.data['errors'] != null) {
                String joinedError = err.response?.data['errors']
                    .map((err) => err['message'])
                    .join('||');

                Tools.showErrorToast(joinedError);
              }
            }
          }
        }
      }

      return null;
    }
    return null;
  }
  // Get All Available PDF Treasures

  Future<TreasuresList> getPdfTreasuresData() async {
    // You will receive a tag (this optional - null)
    StorageService _storageService = locator<StorageService>();
    User user = await _storageService.getUser();
    //
    try {
      final client = await getDioInstance();

      final res =
          await client.get('/app/treasures/?program=${user.selectedProgram}');

      if (res.statusCode == 200) {
        //
        print(
            'GET /app/treasures/?program=${user.selectedProgram} Successfully.');

        final treasuresList = TreasuresList.fromJson(res.data['data']);

        return TreasuresList(treasuresList.treasures);
      }
      return TreasuresList([]);
    } catch (err) {
      throw err;
    }
  }

  // Get App Configuration

  Future<AppConfig?> getAppConfiguration() async {
    // You will receive a tag (this optional - null)
    StorageService _storageService = locator<StorageService>();

    try {
      final client = await getDioInstance();
      final res = await client.get('/app/config');

      if (res.statusCode == 200 &&
          res.data['data'] is Map &&
          (res.data['data'] as Map).isNotEmpty) {
        await _storageService.saveDataToSharedPrefs(
            data: jsonEncode(res.data['data']), key: CACHED_CONFIGURATION_KEY);

        return AppConfig.fromJson(res.data['data']);
      }
    } catch (err) {
      print(err);
    }

    // Check Local Storage For Cached COnfiguration
    final cachedConfig = await _storageService.getDataFromSharedPrefs(
        key: CACHED_CONFIGURATION_KEY);

    if (cachedConfig != null) {
      return AppConfig.fromJson(jsonDecode(cachedConfig));
    } else {
      return null;
    }
  }

  Future<bool> payViaKhalti(
      {required Package package, required dynamic khaltiResponse}) async {
    try {
      final client = await getDioInstance();
      final res = await client.post('/app/pay/khalti-payment', data: {
        'amount': package.price,
        'khalti_response': khaltiResponse,
        'package_id': package.id
      });

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw err;
    }
  }

  Future<bool> payViaEsewa(
      {required Package package, required dynamic esewaResponse}) async {
    try {
      final client = await getDioInstance();
      final res = await client.post('/app/pay/esewa-payment', data: {
        'amount': package.price,
        'esewa_response': esewaResponse,
        'package_id': package.id
      });

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      throw err;
    }
  }

}
