import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extensions/context/context_extensions.dart';
import '../../../../core/extensions/context/theme_extensions.dart';
import '../../../../core/helpers/selector_helper.dart';
import '../../../../core/managers/navigation/navigation_manager.dart';
import '../../../../core/widgets/buttons/action_button.dart';
import '../../../../core/widgets/text/base_text.dart';
import '../../../../product/constants/icon_keys.dart';
import '../../../../product/constants/navigation_constants.dart';
import '../../../../product/language/language_keys.dart';
import '../constants/widget_keys.dart';
import '../view-model/verification_view_model.dart';

part './components/verification_code_field.dart';

class VerificationScreen extends BaseView<VerificationViewModel> {
  const VerificationScreen({Key? key})
      : super(builder: _builder, scrollable: true, key: key);
  static Widget _builder(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(IconKeys.logo, width: context.width * 55),
          context.sizedH(8),
          _title(context, TextKeys.verifyYourEmail),
          context.sizedH(1),
          _description(context, TextKeys.verificationDescription),
          context.sizedH(2),
          const _VerificationCodeField(),
          context.sizedH(2),
          const VerificationCodeTimer(),
          context.sizedH(2),
          _verifyButton,
          context.sizedH(2),
          _backToEnterEmail(context)
          //_backToLogin(context),
        ],
      );

  static Widget _title(BuildContext context, String key, {Color? color}) =>
      BaseText(key, style: context.displayLarge, color: color);

  static Widget _description(BuildContext context, String key,
          {Color? color}) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 10),
          child: BaseText(key, style: context.displayMedium, color: color));

  static Widget get _verifyButton =>
      SelectorHelper<bool, VerificationViewModel>().builder(
          (_, VerificationViewModel model) => model.canVerify,
          (BuildContext context, bool canVerify, _) => ActionButton(
                text: TextKeys.verify,
                padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSize * 2.8,
                    vertical: context.responsiveSize * 1.4),
                capitalizeAll: true,
                isActive: canVerify,
                onPressedError:
                    context.read<VerificationViewModel>().verification,
              ));

  static Widget _backToEnterEmail(BuildContext context) => BaseText(
        TextKeys.backToPrevious,
        style: context.bodySmall,
        replaceValues: <ReplaceValue>[
          ReplaceValue(
            TextKeys.backToPreviousPage,
            onClick: () async => Navigator.pop(context),
            color: context.primary,
          )
        ],
      );
}

class VerificationCodeTimer extends StatefulWidget {
  const VerificationCodeTimer({Key? key}) : super(key: key);

  @override
  State<VerificationCodeTimer> createState() => _VerificationCodeTimerState();
}

class _VerificationCodeTimerState extends State<VerificationCodeTimer> {
  int _remainingTime = 180;
  bool _shouldReset = false;

  void startTimer() {
    const Duration duration = Duration(seconds: 1);
    Timer _timer = Timer.periodic(duration, (timer) {
      if (_remainingTime == 0) {
        setState(() {
          timer.cancel();
        });
      } else if (_shouldReset) {
        setState(() {
          _remainingTime = 180;
          _shouldReset = false;
        });
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void resetTimer() {
    if (_remainingTime > 0) {
      setState(() {
        _shouldReset = true;
      });
    } else {
      setState(() {
        _remainingTime = 180;
        startTimer();
      });
    }
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        BaseText(
          TextKeys.codeNotReceived,
          style: context.bodySmall,
          replaceValues: <ReplaceValue>[
            ReplaceValue(
              TextKeys.requestAnotherCode,
              onClick: () async => {resetTimer()},
              color: context.primary,
            )
          ],
        ),
        context.sizedH(2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseText(
              TextKeys.remainingTime,
              style: context.bodySmall,
            ),
            context.sizedW(2),
            Text('$_remainingTime seconds')
          ],
        )
      ]);

  @override
  void initState() {
    startTimer();
    super.initState();
  }
}
