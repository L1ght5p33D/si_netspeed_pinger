import 'package:localstorage/localstorage.dart';

List<double> zero_result_history = [];
// set user agreed checkbox value outside of rebuild
bool? user_has_ever_agreed = false;
// Google DNS, Cloudflare DNS , ATT DNS
List host_list = ["8.8.8.8", "1.1.1.1", "12.127.16.68"];

List host_name_list = ["Google DNS", "Cloudflare DNS", "AT&T DNS"];

final LocalStorage storage = new LocalStorage('test_log.json');
LocalStorage? gstorage;