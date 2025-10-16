import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/extensions.dart';

void showQRCodeDialog(
    BuildContext context,
    Uint8List? bytes,
    String userId,
    ColorScheme colorScheme,
    ) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: context.screenWidth * 0.9,
          margin: EdgeInsets.only(top: AppSizes.spacingXl),
          constraints: BoxConstraints(maxWidth: 360),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusXl + 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 32,
                offset: Offset(0, 12),
                spreadRadius: -4,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: AppSizes.spacingXl),
              Container(
                padding: EdgeInsets.all(AppSizes.paddingSmall),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  border: Border.all(
                    color: colorScheme.surfaceContainerHighest,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    QrImageView(
                      data: userId,
                      version: QrVersions.auto,
                      size: 220.0,
                      backgroundColor: colorScheme.surface,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: colorScheme.onSurface,
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: colorScheme.onSurface,
                      ),
                      embeddedImage: MemoryImage(bytes!),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(56, 56),
                        color: colorScheme.surface,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(AppSizes.paddingTiny),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary,
                            colorScheme.primary.withValues(alpha: 0.85),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.shade50,
                          child: ClipOval(
                            child: Image.memory(
                              bytes,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spacingLarge),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLarge,
                ),
                child: Text(
                  userId,
                  style: AppTextStyle.body
                      .withColor(colorScheme.onSurface)
                      .withSize(18)
                      .copyWith(letterSpacing: -0.3),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: AppSizes.spacingLarge),
            ],
          ),
        ),
      );
    },
  );
}