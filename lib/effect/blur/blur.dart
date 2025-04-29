import 'dart:ui';

import 'package:flutter/material.dart';

void showBlurOverlay(BuildContext context) {
  OverlayEntry overlayEntry;
  overlayEntry = OverlayEntry(
    builder:
        (context) => Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(
                    0.3,
                  ), // Semi-transparent overlay
                ),
              ),
            ),
            Center(child: CircularProgressIndicator(color: Colors.white)),
          ],
        ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
