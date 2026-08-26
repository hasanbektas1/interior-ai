import 'package:flutter/material.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:video_player/video_player.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: _WelcomeVideoPlayer(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.onboardingWelcomeTo,
                      style: TextStyle(
                        color: AppColors.richBlack,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: AppStrings.appName,
                      style: TextStyle(
                        color: AppColors.hanPurple,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                AppStrings.onboardingSubtitle,
                style: TextStyle(
                  color: AppColors.richBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

class _WelcomeVideoPlayer extends StatefulWidget {
  const _WelcomeVideoPlayer();

  @override
  State<_WelcomeVideoPlayer> createState() => _WelcomeVideoPlayerState();
}

class _WelcomeVideoPlayerState extends State<_WelcomeVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/mp4/onboardingFirstPageVideo.mp4',
    );
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: !_isInitialized
          ? Container(
              key: const ValueKey('loading'),
              decoration: BoxDecoration(
                color: const Color(0x1A712BFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF712BFF),
                  strokeWidth: 3,
                ),
              ),
            )
          : ClipRRect(
              key: const ValueKey('video'),
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),
    );
  }
}
