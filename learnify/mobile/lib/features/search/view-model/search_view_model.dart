import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../home/service/I_home_service.dart';
import '../../home/service/home_service.dart';
import '../../../../core/base/view-model/base_view_model.dart';
import '../../../core/managers/network/models/l_response_model.dart';
import '../../../product/constants/icon_keys.dart';
import '../../home/model/get_learning_spaces_response_model.dart';
import '../../learning-space/models/learning_space_model.dart';
import '../model/search_response_model.dart';
import '../service/i_search_service.dart';
import '../service/search_service.dart';
import '../view/search_screen.dart';

/// View model to manage the data on search screen.
class SearchViewModel extends BaseViewModel {
  late final ISearchService _searchService;
  late final IHomeService _homeService;

  late TextEditingController _searchController;
  TextEditingController get searchController => _searchController;

  late List<LearningSpace> _resultLearningSpaces = <LearningSpace>[];
  List<LearningSpace> get resultLearningSpaces => _resultLearningSpaces;

  late List<LearningSpace> _recommendedLearningSpaces = <LearningSpace>[];
  List<LearningSpace> get recommendedLearningSpaces =>
      _recommendedLearningSpaces;

  late final List<UserPreview> _allUsers = <UserPreview>[
    const UserPreview(
        userName: "Altay Akar", profilePhoto: IconKeys.profilePageAltay),
    const UserPreview(
        userName: "Bahrican Kırmızı",
        profilePhoto: IconKeys.profilePageBahrican),
    const UserPreview(
        userName: "Batuhan Nikel", profilePhoto: IconKeys.profilePageBatuhan),
    const UserPreview(
        userName: "Ezgi Doğu", profilePhoto: IconKeys.profilePageEzgi),
    const UserPreview(
        userName: "Ecenur Sezar", profilePhoto: IconKeys.profilePageEce),
    const UserPreview(
        userName: "Egemen Yavaş", profilePhoto: IconKeys.profilePageEgemen),
    const UserPreview(
        userName: "Enes Sürmesiz", profilePhoto: IconKeys.profilePageEnes),
    const UserPreview(
        userName: "Hasan Askerol", profilePhoto: IconKeys.profilePageHasan),
    const UserPreview(
        userName: "Onur Karboncu", profilePhoto: IconKeys.profilePageOnur),
    const UserPreview(
        userName: "Gökay Güneş", profilePhoto: IconKeys.profilePageGokay),
    const UserPreview(
        userName: "Koray Tekçık", profilePhoto: IconKeys.profilePageKoray),
  ];

  late List<UserPreview> _resultUsers = _allUsers;
  List<UserPreview> get resultUsers => _resultUsers;

  late bool didResultCome = false;

  @override
  void initViewModel() {
    _searchService = SearchService.instance;
    _homeService = HomeService.instance;
  }

  @override
  void initView() {
    _searchController = TextEditingController();
    _searchController.addListener(_controllerListener);
    _getRecommendedLearningSpaces();
    _setDefault();
  }

  @override
  void disposeView() {
    _searchController.dispose();
    _resultLearningSpaces = <LearningSpace>[];
    _recommendedLearningSpaces = <LearningSpace>[];
    _setDefault();
    super.disposeView();
  }

  void _setDefault() {}

  void clearResults() {
    _searchController.clear();
    _resultLearningSpaces = _recommendedLearningSpaces;
    _resultUsers = _allUsers;
    notifyListeners();
  }

  Future<void> _controllerListener() async {
    if (searchController.text.isEmpty) return;
    notifyListeners();
  }

  Future<String?> _getRecommendedLearningSpaces() async {
    await operation?.cancel();
    operation = CancelableOperation<String?>.fromFuture(
        _getRecommendedLearningSpacesRequest());
    final String? res = await operation?.valueOrCancellation();
    return res;
  }

  Future<String?> _getRecommendedLearningSpacesRequest() async {
    final IResponseModel<GetLearningSpacesResponse> resp =
        await _homeService.getLearningSpaces();
    final GetLearningSpacesResponse? respData = resp.data;
    if (resp.hasError || respData == null) return resp.error?.errorMessage;
    _recommendedLearningSpaces = respData.learningSpaces;
    _resultLearningSpaces = _recommendedLearningSpaces;
    notifyListeners();
    return null;
  }

  Future<String?> search() async {
    await operation?.cancel();
    operation = CancelableOperation<String?>.fromFuture(_searchRequest());
    final String? res = await operation?.valueOrCancellation();
    return res;
  }

  Future<String?> _searchRequest() async {
    if (_searchController.text.isEmpty) {
      clearResults();
      return null;
    }
    final IResponseModel<SearchResponse> resp =
        await _searchService.search(_searchController.text);
    await _userSearchRequest(_searchController.text);
    final SearchResponse? respData = resp.data;
    if (resp.hasError || respData == null) {
      clearResults();
      return resp.error?.errorMessage;
    }
    if (respData.resultLearningSpaces.isEmpty) {
      _resultLearningSpaces = _recommendedLearningSpaces;
    } else {
      _resultLearningSpaces = respData.resultLearningSpaces;
    }
    notifyListeners();
    return null;
  }
  void setDefault() {
    _resultLearningSpaces = [];
    didResultCome = false;
}

  Future<UserPreview?> _userSearchRequest(String name) async {
    _resultUsers = _allUsers;
    for (final UserPreview user in _allUsers) {
      if (user.userName.split(" ")[0].toLowerCase() == name.toLowerCase()) {
        _resultUsers = <UserPreview>[user];
      }
    }
    return null;
  }
}
