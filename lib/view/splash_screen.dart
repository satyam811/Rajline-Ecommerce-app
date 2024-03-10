import 'package:flutter/material.dart';
import 'package:raj_lines/main_screen.dart';
import 'package:raj_lines/utils/shared_prefs.dart';
import 'package:raj_lines/view/onboarding/onboarding_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _videoController.addListener(() {
      if (_videoController.value.position == _videoController.value.duration) {
        final token = SharedPrefs.instance().token;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              token != null ? const MainScreen() : const OnBoardingScreen(),
        ));
      }
    });
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.asset('assets/dumy/splash.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/dumy/Final 4K_1.mp4')
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown and then start playing
  //       setState(() {});
  //       _controller.play();
  //       _controller.addListener(() {
  //         if (_controller.value.position >= _controller.value.duration) {
  //           // Video has ended, navigate to the login screen
  //           Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) => OnBoardingScreen(),
  //           ));
  //         }
  //       });
  //     });
  // }
  //     @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/dumy/Final 4K_1.mp4')
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown and then start playing
  //       setState(() {});
  //       _controller.play();
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Video background

          if (_videoController.value.isInitialized)
            AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
          // Add other widgets on top of the video here
          // For example, you can display your app's logo or loading indicators.
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }
}
