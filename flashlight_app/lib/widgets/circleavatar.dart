import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({super.key});

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  bool _isFlashon = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 80,
      minRadius: 40,
      child: Transform.scale(
        scale: 2,
        child: IconButton(
          onPressed: () async {
            if (await _isTorchAvailable(context)) {
              toggleFlashLight();
            } else {
              _showErrorMes("Flash is not available in your device", context);
            }
          },
          icon: Icon(
            _isFlashon ? Icons.flash_on_rounded : Icons.flash_off_rounded,
            color: _isFlashon ? Colors.blue : Colors.red,
          ),
        ),
      ),
    );
  }

  Future<bool> _isTorchAvailable(BuildContext context) async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      _showErrorMes('Flash is not available in your device', context);
      rethrow;
    }
  }

  Future<void> toggleFlashLight() async {
    try {
      setState(() {
        _isFlashon = !_isFlashon;
      });
      if (_isFlashon) {
        await TorchLight.enableTorch();
        _showErrorMes("Flash is on", context);
      } else {
        await TorchLight.disableTorch();
        _showErrorMes("Flash is off", context);
      }
    } catch (e) {
      _showErrorMes('$e', context);
    }
  }

  void _showErrorMes(String mes, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mes)));
  }
}
