
import '../../enums/viewstate.dart';
import '../../locator.dart';
import '../../models/my_stat.dart';
import '../../services/api_service.dart';
import 'base_model.dart';

class UserStatModel extends BaseModel {
  MyStat? _myStat;

  MyStat? get myStat => _myStat;

  Api _api = locator<Api>();
  Future<bool> getMyStat() async {
    setState(ViewState.Busy);

    try {
      // await Future.delayed(Duration(seconds: 20));
      final MyStat? fetchedStat = await _api.getMyStat();
      // print(fetchedStat.totalCorrectAttempt);

      if (fetchedStat != null) {
        _myStat = fetchedStat;
        setState(ViewState.Idle);
        return true;
      }
      setState(ViewState.Idle);
      return false;
    } catch (err) {
      print(err);
      setState(ViewState.Idle);
      return false;
    }
  }
}
