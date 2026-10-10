import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../onboarding/presentation/widgets/onboarding_illustrations.dart';
import 'paywall_palette.dart';

/// Decorative artwork at the top of the paywall: the looping feature video
/// (`assets/paywall/paywall_hero.mp4`) over a pink gradient. The widget-built
/// breakdown card and coins show underneath while the video loads, if it
/// fails, and when the user has asked for reduced motion.
///
/// Fills whatever box it is given (including behind the status bar) and keeps
/// its artwork below [topInset] and above [bottomInset].
class PaywallHero extends StatefulWidget {
  const PaywallHero({super.key, this.topInset = 0, this.bottomInset = 0});

  /// Space reserved at the top (status bar, close button).
  final double topInset;

  /// Space reserved at the bottom (where the offer sheet overlaps).
  final double bottomInset;

  @override
  State<PaywallHero> createState() => _PaywallHeroState();
}

class _PaywallHeroState extends State<PaywallHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3200),
  );

  VideoPlayerController? _video;
  bool _videoReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _float
        ..stop()
        ..value = 0.5;
      _video?.pause();
    } else {
      if (!_float.isAnimating) _float.repeat();
      _video ??= _startVideo();
      if (_videoReady) _video!.play();
    }
  }

  VideoPlayerController _startVideo() {
    final controller = VideoPlayerController.asset(
      PaywallHeroVideo.asset,
      // Never interrupt the user's music or podcasts.
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    () async {
      try {
        await controller.initialize();
        await controller.setVolume(0);
        await controller.setLooping(true);
        if (!mounted) return;
        if (!MediaQuery.disableAnimationsOf(context)) await controller.play();
        if (mounted) setState(() => _videoReady = true);
      } catch (_) {
        // Keep the illustrated fallback if the video can't play.
      }
    }();
    return controller;
  }

  @override
  void dispose() {
    _float.dispose();
    _video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.pink, AppColors.pinkSoft],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Soft light blobs for depth.
            const Positioned(
              top: -60,
              right: -40,
              child: _Glow(size: 220, opacity: 0.35),
            ),
            const Positioned(
              bottom: 10,
              left: -70,
              child: _Glow(size: 200, opacity: 0.4),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: widget.topInset,
                bottom: widget.bottomInset,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: _Artwork(float: _float),
                ),
              ),
            ),
            if (_video != null)
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity:
                      _videoReady && !MediaQuery.disableAnimationsOf(context)
                      ? 1
                      : 0,
                  duration: const Duration(milliseconds: 400),
                  child: _videoReady
                      ? PaywallHeroVideo(
                          controller: _video!,
                          topInset: widget.topInset,
                          bottomInset: widget.bottomInset,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The hero video, cropped to fill the box. The crop centres the video's
/// subject between [topInset] and [bottomInset] while keeping its top and
/// bottom margins (which carry stray caption text) out of view.
class PaywallHeroVideo extends StatelessWidget {
  const PaywallHeroVideo({
    super.key,
    required this.controller,
    this.topInset = 0,
    this.bottomInset = 0,
  });

  static const String asset = 'assets/paywall/paywall_hero.mp4';

  /// Vertical centre of the animated subject, as a fraction of video height.
  static const double _subjectCenter = 0.53;

  /// Fractions of the video height to keep hidden at the top and bottom.
  static const double _hiddenTop = 0.115;
  static const double _hiddenBottom = 0.91;

  final VideoPlayerController controller;
  final double topInset;
  final double bottomInset;

  @override
  Widget build(BuildContext context) {
    final size = controller.value.size;
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxW = constraints.maxWidth;
        final boxH = constraints.maxHeight;
        if (size.isEmpty || boxW == 0 || boxH == 0) {
          return const SizedBox.shrink();
        }
        final scale = math.max(boxW / size.width, boxH / size.height);
        final videoW = size.width * scale;
        final videoH = size.height * scale;

        // Put the subject in the middle of the visible artwork area…
        final windowCenter = topInset + (boxH - topInset - bottomInset) / 2;
        var offsetY = _subjectCenter * videoH - windowCenter;
        // …but never reveal the hidden margins, when the box allows it…
        final minOffset = _hiddenTop * videoH;
        final maxOffset = _hiddenBottom * videoH - boxH;
        if (minOffset <= maxOffset) {
          offsetY = offsetY.clamp(minOffset, maxOffset);
        }
        // …and never leave a gap at the edges.
        offsetY = offsetY.clamp(0.0, videoH - boxH);

        return ClipRect(
          child: Stack(
            children: [
              Positioned(
                left: -(videoW - boxW) / 2,
                top: -offsetY,
                width: videoW,
                height: videoH,
                child: VideoPlayer(controller),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.background.withValues(alpha: opacity),
            AppColors.background.withValues(alpha: 0),
          ],
        ),
      ),
    );
  }
}

/// Fixed-size composition, scaled down as a whole when the hero is short.
class _Artwork extends StatelessWidget {
  const _Artwork({required this.float});

  final Animation<double> float;

  static const double _width = 320;
  static const double _height = 250;

  @override
  Widget build(BuildContext context) {
    // Without text scaling: the artwork is a picture, not reading text.
    return MediaQuery.withNoTextScaling(
      child: SizedBox(
        width: _width,
        height: _height,
        child: AnimatedBuilder(
          animation: float,
          builder: (context, _) {
            final phase = float.value * 2 * math.pi;
            final cardDy = math.sin(phase) * 3;
            final coinsDy = math.sin(phase + math.pi / 2) * 6;
            final coinTilt = math.sin(phase) * 0.06;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  top: 18 + cardDy,
                  child: Transform.rotate(
                    angle: -0.04,
                    child: const BreakdownIllustration(),
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 6 + coinsDy * 0.4,
                  child: const _CoinPile(),
                ),
                Positioned(
                  right: 22,
                  bottom: 82 - coinsDy,
                  child: Transform.rotate(
                    angle: 0.12 + coinTilt,
                    child: const _CoinFace(size: 74),
                  ),
                ),
                Positioned(
                  left: -8,
                  bottom: 8 + coinsDy * 0.7,
                  child: Transform.rotate(
                    angle: -0.25 - coinTilt,
                    child: const _CoinFace(size: 42),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 6 - cardDy,
                  child: const _Sparkle(size: 18),
                ),
                Positioned(
                  right: 6,
                  top: 30 + cardDy,
                  child: const _Sparkle(size: 13),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// A front-facing gold coin stamped "Rs".
class _CoinFace extends StatelessWidget {
  const _CoinFace({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final rim = size * 0.09;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: PaywallPalette.coinEdge,
        border: Border.all(color: AppColors.ink, width: 2),
        boxShadow: [
          BoxShadow(
            color: PaywallPalette.coinEdge.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: rim * 0.6),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [PaywallPalette.coinLight, PaywallPalette.coinDeep],
          ),
        ),
        padding: EdgeInsets.all(rim),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: PaywallPalette.coinText.withValues(alpha: 0.25),
              width: math.max(1, size * 0.03),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'Rs',
            style: TextStyle(
              fontSize: size * 0.32,
              height: 1,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: PaywallPalette.coinText,
            ),
          ),
        ),
      ),
    );
  }
}

/// Coins lying flat, stacked: a column of gold "slices" seen side-on.
class _CoinPile extends StatelessWidget {
  const _CoinPile();

  static const int _count = 4;
  static const double _sliceHeight = 16;
  static const double _step = 11;
  static const double _width = 96;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width + 8,
      height: _sliceHeight + _step * (_count - 1),
      child: Stack(
        children: [
          for (var i = 0; i < _count; i++)
            Positioned(
              bottom: i * _step,
              // Slightly uneven stack so it reads as hand-placed.
              left: i.isEven ? 0 : 6,
              child: const _CoinSlice(width: _width, height: _sliceHeight),
            ),
        ],
      ),
    );
  }
}

class _CoinSlice extends StatelessWidget {
  const _CoinSlice({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(height / 2)),
        border: Border.all(color: AppColors.ink, width: 2),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [PaywallPalette.coinLight, PaywallPalette.coinDeep],
          stops: [0.45, 0.55],
        ),
      ),
    );
  }
}

/// Four-point twinkle.
class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.auto_awesome, size: size, color: AppColors.onInk);
  }
}
