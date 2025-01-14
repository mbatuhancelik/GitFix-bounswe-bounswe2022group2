import 'package:flutter/material.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../core/extensions/context/context_extensions.dart';
import '../../../core/widgets/app-bar/default_app_bar.dart';
import '../../../core/widgets/divider/custom_divider.dart';
import '../../../core/widgets/text/base_text.dart';
import '../../../product/language/language_keys.dart';
import '../constants/settings_options.dart';
import '../view-model/settings_view_model.dart';
import 'components/settings_item.dart';

class SettingsScreen extends BaseView<SettingsViewModel> {
  const SettingsScreen({Key? key})
      : super(appBar: _appBarBuilder, builder: _builder, key: key);

  static Widget _builder(BuildContext context) {
    final int optionLength = SettingsOptions.values.length;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.height * 1),
      child: ListView.builder(
        itemCount: optionLength + 1,
        itemBuilder: (BuildContext context, int index) => index == optionLength
            ? Padding(
                padding: EdgeInsets.only(top: context.height * 2),
                child: const BaseText(TextKeys.madeBy),
              )
            : Column(
                children: <Widget>[
                  SettingsItem(settings: SettingsOptions.values[index]),
                  const CustomDivider(),
                ],
              ),
      ),
    );
  }

  static DefaultAppBar _appBarBuilder(BuildContext context) => DefaultAppBar(
        size: context.height * 6,
        titleText: TextKeys.settings,
        showBack: true,
        padding: EdgeInsets.symmetric(
            horizontal: context.responsiveSize * 3,
            vertical: context.responsiveSize * 2.5),
      );
}
