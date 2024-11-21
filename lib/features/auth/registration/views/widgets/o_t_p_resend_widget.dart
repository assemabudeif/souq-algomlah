import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/core/theme/app_color.dart';
import '/core/utilities/extensions.dart';
import '/features/auth/registration/viewmodel/registration_cubit.dart';

class OTPResendWidget extends StatefulWidget {
  const OTPResendWidget({
    super.key,
    required this.vm,
    required this.email,
  });

  final RegistrationCubit vm;
  final String email;

  @override
  State<OTPResendWidget> createState() => _OTPResendWidgetState();
}

class _OTPResendWidgetState extends State<OTPResendWidget> {
  final int _maxTime = 60;
  int _time = 0;

  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  dispose() {
    _timer!.cancel();
    super.dispose();
  }

  _startTimer() async {
    _time = _maxTime;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (_time == 0) {
          _timer!.cancel();
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  _resend() {
    widget.vm.resendOTP(context, widget.email);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_time == 0)
          TextButton(
            onPressed: () {
              _resend();
            },
            child: Text(
              context.locale == const Locale('en')
                  ? "Resend OTP"
                  : "إعادة إرسال رمز التحقق",
              style: const TextStyle(color: AppColors.primary),
            ),
          )
        else
          Text(
            _time.toString(),
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.primary,
            ),
          ),
      ],
    );
  }
}
