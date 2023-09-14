import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:flashlight_app/widgets/circleavatar.dart';

class FlashLightScreen extends StatefulWidget {
  const FlashLightScreen({super.key});

  @override
  State<FlashLightScreen> createState() => _FlashLightScreenState();
}

class _FlashLightScreenState extends State<FlashLightScreen>
    with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  bool _isFlashon = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
    });
    if (state == AppLifecycleState.paused) {
      TorchLight.disableTorch();
    } else if (state == AppLifecycleState.resumed) {
      if (_isFlashon == true) {
        TorchLight.enableTorch();
      } else {
        TorchLight.disableTorch();
      }
    } else if (state == AppLifecycleState.inactive) {
      TorchLight.disableTorch();
    } else if (state == AppLifecycleState.detached) {}
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flashlight App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.001),
              const Text(
                "Flashlight",
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 50),
              const CustomCircleAvatar(),
            ],
          ),
        ),
      ),
    );
  }
}
