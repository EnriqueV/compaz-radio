import 'package:compaz_radio/utils/config.dart';


class ApiHelper {
  static url (String endpoint) {
    return Uri.parse('${Config.baseUrl}$endpoint');
  }

}