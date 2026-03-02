import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/res/app_assets.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, this.helpingMessage, this.onRefresh, this.throttleDuration = const Duration(seconds: 2)});

  final String? helpingMessage;
  final Future<void> Function()? onRefresh;
  final Duration throttleDuration;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  DateTime? _lastRefreshTime;

  Future<void> _handleRefresh() async {
    final now = DateTime.now();

    if (_lastRefreshTime != null && now.difference(_lastRefreshTime!) < widget.throttleDuration) {
      if (mounted) {
        context.showSnackBar('errors.pleasewait'.tr(), isError: false);
      }
      return;
    }

    _lastRefreshTime = now;
    await widget.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // make it fill the screen
              ),
              child: Center(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: .min,
                      spacing: 16,
                      children: <Widget>[
                        Opacity(opacity: 0.7, child: LottieBuilder.asset(AppAssets.errorAnimation, repeat: false, width: 200, height: 200)),
                        Text('errors.somethingWentWrong'.tr(), textAlign: TextAlign.center, style: context.textTheme.titleMedium),
                        if (widget.helpingMessage != null)
                          Padding(
                            padding: const .symmetric(horizontal: 16.0),
                            child: Text(
                              widget.helpingMessage!,
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium?.copyWith(color: context.textTheme.bodyMedium?.color?.withAlpha(200)),
                            ),
                          ),
                        if (widget.onRefresh != null)
                          FilledButton.icon(
                            label: Text('errors.refresh'.tr()),
                            icon: const Icon(Icons.refresh_rounded),
                            onPressed: _handleRefresh,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
