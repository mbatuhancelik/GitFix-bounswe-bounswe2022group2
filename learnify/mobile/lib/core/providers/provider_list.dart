import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/forget-password/view-model/forget_password_view_model.dart';
import '../../features/auth/signup/view-model/signup_view_model.dart';
import '../../features/auth/login/view-model/login_view_model.dart';
import '../../features/auth/verification/view-model/verification_view_model.dart';
import '../../features/courses/view-model/courses_view_model.dart';
import '../../features/home-wrapper/view-model/home_wrapper_view_model.dart';
import '../../features/home/view-model/home_view_model.dart';
import '../../features/profile/view-model/profile_view_model.dart';
import '../../features/search/view-model/search_view_model.dart';
import '../managers/navigation/navigation_manager.dart';
import 'language/language_provider.dart';
import 'theme/theme_provider.dart';

/// Provides the list of providers will be used across the app.
class ProviderList {
  /// Singleton instance of [ProviderList].
  factory ProviderList() => _instance;
  ProviderList._();
  static final ProviderList _instance = ProviderList._();

  /// List of providers will be used for main [MultiProvider] class.
  static final List<SingleChildWidget> providers = <SingleChildWidget>[
    ..._functionalProviders,
    ..._viewModelProviders,
  ];

  static final List<SingleChildWidget> _viewModelProviders =
      <SingleChildWidget>[
    ChangeNotifierProvider<SignupViewModel>(
      lazy: true,
      create: (_) => SignupViewModel(),
    ),
    ChangeNotifierProvider<LoginViewModel>(
      lazy: true,
      create: (_) => LoginViewModel(),
    ),
    ChangeNotifierProvider<HomeWrapperViewModel>(
      lazy: true,
      create: (_) => HomeWrapperViewModel(),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      lazy: true,
      create: (_) => HomeViewModel(),
    ),
    ChangeNotifierProvider<SearchViewModel>(
      lazy: true,
      create: (_) => SearchViewModel(),
    ),
    ChangeNotifierProvider<CoursesViewModel>(
      lazy: true,
      create: (_) => CoursesViewModel(),
    ),
    ChangeNotifierProxyProvider<HomeWrapperViewModel, ProfileViewModel>(
      lazy: true,
      create: (BuildContext context) =>
          ProfileViewModel(context.read<HomeWrapperViewModel>().user),
      update: (_, HomeWrapperViewModel viewModel,
          ProfileViewModel? profileViewModel) {
        final ProfileViewModel updatedModel =
            profileViewModel ?? ProfileViewModel(viewModel.user)
              ..updateUser(viewModel.user);
        return updatedModel;
      },
    ),
    ChangeNotifierProvider<ForgetPasswordViewModel>(
      lazy: true,
      create: (_) => ForgetPasswordViewModel(),
    ),
    ChangeNotifierProvider<VerificationViewModel>(
      lazy: true,
      create: (_) => VerificationViewModel(),
    ),
    ChangeNotifierProvider<ForgetPasswordViewModel>(
      lazy: true,
      create: (_) => ForgetPasswordViewModel(),
    ),
    ChangeNotifierProvider<VerificationViewModel>(
      lazy: true,
      create: (_) => VerificationViewModel(),
    ),
  ];

  static final List<SingleChildWidget> _functionalProviders =
      <SingleChildWidget>[
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
    ),
    ChangeNotifierProvider<LanguageProvider>(
      create: (_) => LanguageProvider(),
    ),
    Provider<NavigationManager>.value(value: NavigationManager.instance)
  ];
}