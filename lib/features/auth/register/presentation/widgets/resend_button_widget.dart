import 'dart:async';

import 'package:cars_equipments_shop/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResendButton extends StatefulWidget {
  const ResendButton({super.key});

  @override
  _ResendButtonState createState() => _ResendButtonState();
}

class _ResendButtonState extends State<ResendButton> {
  bool _isCountdownActive = false;
  int _countdownSeconds = 120; // 2 minutes in seconds

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isCountdownActive ? null : _startCountdown,
      child: Text(_isCountdownActive ? '$_countdownSeconds' : 'Resend'),
    );
  }

  void _startCountdown() {
    setState(() {
      _isCountdownActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdownSeconds--;

        if (_countdownSeconds == 0) {
          _timer?.cancel();
          _isCountdownActive = false;
        }
      });
    });
    
    BlocProvider.of<RegisterBloc>(context).add(ResendEmailValidationEvent());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
