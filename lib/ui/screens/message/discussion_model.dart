

import '../../../enums/viewstate.dart';
import '../../../locator.dart';
import '../../../models/topic.dart';
import '../../../services/api_service.dart';
import '../../viewmodels/base_model.dart';

class DiscussionModel extends BaseModel {
  Api _api = locator<Api>();

  TopicList? _topicList;

  TopicList? get topicList => _topicList;

  Future<void> fetchAllTopics() async {
    setState(ViewState.Busy);
    try {
      TopicList? fetchedTopicList =
          await _api.getAllTopics();

      _topicList = fetchedTopicList;

      setState(ViewState.Idle);
    } catch (err) {
      setState(ViewState.Idle);
    }
  }

  Future<bool> createTopic(
      {String? name, String description = ''}) async {
    setState(ViewState.Busy);
    try {
      bool success = await _api.createTopic(
          name: name!, description: description);

      if (success) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
