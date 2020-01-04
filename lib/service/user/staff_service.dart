import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../auth/token_service.dart';
import '../woorinaru_service.dart';

import '../../model/user/user.dart';

class StaffService extends WoorinaruService {
  Logger log = new Logger('StaffService');


  StaffService({
    @required String baseUrl,
    @required TokenService tokenService,
  }) : super(baseUrl: baseUrl, tokenService: tokenService);

  Future<bool> createStaff(User staff) async {
    log.info('Creating staff');
    String url = '$baseUrl/staff';

    Response response = await this.httpClient.post(url, data: staff.toJson());

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getStaff(int id) async {
    log.info('Getting staff with id: $id');

    String url = '$baseUrl/staff/$id';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('There are no staff member with id: $id');
      return null;
    }

    User user = User.fromJson(response.data);
    return user;
  }

  Future<List<User>> getStaffList() async {
    log.info('Getting all staff');

    String url = '$baseUrl/staff';
    Response response = await this.httpClient.get(url);

    if (response.data == null) {
      log.warning('Invalid request');
      return null;
    }

    List<User> staff = [];
    List<dynamic> jsonResponse = response.data;

    jsonResponse.forEach((json) {
      staff.add(User.fromJson(json));
    });

    return staff;
  }

  Future<bool> deleteStaff(int id) async {
    log.info('Deleting staff with id: $id');

    String url = '$baseUrl/staff/$id';
    Response response = await this.httpClient.delete(url);

    if (response.statusCode == 200) {
      // Success
      return true;
    } else {
      return false;
    }
  }

  Future<bool> modifyStaff(User staff) async {
    log.info('Modifying staff with id: ${staff.id}');

    String url = '$baseUrl/staff';

    Response response = await this.httpClient.put(url, data: staff.toJson());

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
