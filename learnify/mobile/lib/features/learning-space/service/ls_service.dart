import 'dart:core';
import 'dart:core';
import 'dart:ffi';

import '../../../../core/managers/network/models/l_response_model.dart';
import '../../../core/base/model/base_model.dart';
import '../../../core/constants/enums/request_types.dart';
import '../../../core/managers/network/models/message_response.dart';
import '../models/create_ls_request_model.dart';
import '../models/create_ls_response_model.dart';
import '../view/create_learning_space_screen.dart';
import 'l_ls_service.dart';

/// Service for network request of auth view-model.
class LSService extends ILSService {
  /// Factory constructor for singleton structure.
  factory LSService() => _instance;
  LSService._();

  static final LSService _instance = LSService._();

  /// Static instance getter of [LSService].
  static LSService get instance => _instance;

  static const String _create = '/learningSpace';
  static const String _categories = '/categories';

  @override
  Future<IResponseModel<CreateLSResponse>> createLS(
          CreateLSRequest body) async =>
      networkManager.send<CreateLSRequest, CreateLSResponse>(
        _create,
        parseModel: const CreateLSResponse(),
        type: RequestTypes.post,
        body: body,
      );

  @override
  Future<List<String>> getCategories() async =>
      BaseModel.getList(networkManager.send<CreateLSRequest, Categories>(
        _categories,
        type: RequestTypes.get,
        parseModel: List,
      ));
}

