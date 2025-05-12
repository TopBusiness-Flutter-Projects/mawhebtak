import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_cubit.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_state.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime targetTime; // The time to countdown to

  const CountdownTimer({
    Key? key,
    required this.targetTime,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remainingTime;
  late Timer _timer;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.targetTime.isAfter(DateTime.now())
        ? widget.targetTime.difference(DateTime.now())
        : Duration.zero;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = widget.targetTime.isAfter(DateTime.now())
            ? widget.targetTime.difference(DateTime.now())
            : Duration.zero;

        minutes = remainingTime.inMinutes;
        seconds = remainingTime.inSeconds % 60;
      });

      if (remainingTime <= Duration.zero) {
        _timer.cancel();

// Call the reset method in the Cubit using post-frame callback
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<VerificationCubit>().resetTimerAndOTP();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();

// Call the reset method in the Cubit using post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VerificationCubit>().resetTimerAndOTP();
    });
    super.dispose();
  }

  String _formatTime(int minutes, int seconds) {
    return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
  }

  String _twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerificationCubit, VerificationState>(
      builder: (context, state) {
        return Text(
          _formatTime(minutes, seconds),
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary),
        );
      },
    );
  }
}
