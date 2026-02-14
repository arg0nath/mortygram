import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/res/app_assets.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.helpingMessage});

  final String? helpingMessage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
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
                      Text('Something went wrong.', textAlign: TextAlign.center, style: context.textTheme.titleMedium),
                      if (helpingMessage != null)
                        Padding(
                          padding: const .symmetric(horizontal: 16.0),
                          child: Text(
                            helpingMessage!,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyMedium?.copyWith(color: context.textTheme.bodyMedium?.color?.withAlpha(200)),
                          ),
                        ),
                    ],
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
