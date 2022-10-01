import 'package:dio/dio.dart';
import 'package:feature_oriented/core/network/repositories/base_repo_impl.dart';
import 'package:feature_oriented/core/utils/constants.dart';
import 'package:feature_oriented/feature/login/data/models/login_model.dart';
import 'package:feature_oriented/feature/login/domain/entities/login_params.dart';

part 'login_remote.dart';

class LoginRemoteRepoImpl extends BaseRepoImpl implements LoginRemoteRepo {
  @override
  Future<LoginData> loginUser(LoginParams params) async {
    const url = loginEndpoint;
    final Response response = await postWithParams(url, params.toJson());
    return LoginData.fromJson(response.data);
  }

  @override
  Future<bool> checkTokenValidation() async {
    const url = checkTokenEndpoint;
    await getWithoutParams(url);
    return true;
  }
}
