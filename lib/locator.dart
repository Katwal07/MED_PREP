import 'package:get_it/get_it.dart';
import 'package:med_prep/ui/viewmodels/base_model.dart';

import 'config/app_config.dart';
import 'config/config.dart';
import 'services/api_service.dart';
import 'services/authentication_service.dart';
import 'services/storage_service.dart';
import 'ui/screens/message/discussion_model.dart';
import 'ui/viewmodels/account_model.dart';
import 'ui/viewmodels/exam_model.dart';
import 'ui/viewmodels/login_model.dart';
import 'ui/viewmodels/manual_payment.dart';
import 'ui/viewmodels/package_base_model.dart';
import 'ui/viewmodels/payment_base_model.dart';
import 'ui/viewmodels/qod_model.dart';
import 'ui/viewmodels/result_model.dart';
import 'ui/viewmodels/section_model.dart';
import 'ui/viewmodels/signup_model.dart';
import 'ui/viewmodels/treasures_model.dart';
import 'ui/viewmodels/userstat_model.dart';
import 'ui/widgets/workout/option_container_viewmodel.dart';

final locator = GetIt.instance;

void setupLocator({required Flavor flavor}) {
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton<IConfig>(() => flavor == Flavor.PROD
      ? ProdConfig()
      : flavor == Flavor.DEV
          ? DevConfig()
          : LocalConfig());

  // locator.registerFactory(() => StatementModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => SignupModel());
  locator.registerFactory(() => BaseModel());
  locator.registerFactory(() => ExamViewModel());
  locator.registerFactory(() => QuestionOfDayModel());
  locator.registerFactory(() => AccountModel());
  locator.registerFactory(() => OptionContainerViewModel());
  locator.registerFactory(() => UserStatModel());
  locator.registerFactory(() => SectionViewModel());
  locator.registerFactory(() => DiscussionModel());
  locator.registerFactory(() => PaymentViewModel());
  locator.registerFactory(() => PackageViewModel());
  locator.registerFactory(() => ManualPaymentModel());
  locator.registerFactory(() => TreasuresViewModel());
  locator.registerFactory(() => ResultViewModel());
}
