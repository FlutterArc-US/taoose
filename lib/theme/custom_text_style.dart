import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyMedium14 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMediumAirbnbCerealAppGray600 =>
      theme.textTheme.bodyMedium!.airbnbCerealApp.copyWith(
        color: appTheme.gray600,
        fontSize: 14.fSize,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900.withOpacity(0.4),
        fontSize: 14.fSize,
      );
  static get bodyMediumBluegray300 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray300,
      );
  static get bodyMediumBluegray40001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray40001,
      );
  static get bodyMediumGray500 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
      );
  static get bodyMediumGray60002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray60002,
      );
  static get bodyMediumGray60002Light => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray60002,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodyMediumGray700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray700,
        fontSize: 14.fSize,
      );
  static get bodyMediumGray900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray900,
        fontSize: 14.fSize,
      );
  static get bodyMediumGray90002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90002,
        fontSize: 14.fSize,
      );
  static get bodyMediumGray9000214 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90002,
        fontSize: 14.fSize,
      );
  static get bodyMediumGray90005 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90005,
        fontSize: 14.fSize,
      );
  static get bodyMediumOnPrimaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 14.fSize,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodyMediumPrimaryContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  static get bodyMediumProximaNova2PrimaryContainer =>
      theme.textTheme.bodyMedium!.proximaNova2.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyMediumProximaNova2PrimaryContainer_1 =>
      theme.textTheme.bodyMedium!.proximaNova2.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyMediumProximaNovaPrimaryContainer =>
      theme.textTheme.bodyMedium!.proximaNova.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyMediumRedA400 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.redA400,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.4),
        fontSize: 12.fSize,
      );
  static get bodySmallGray50003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
        fontSize: 12.fSize,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
        fontSize: 12.fSize,
      );
  static get bodySmallNetflixSansGray50003 =>
      theme.textTheme.bodySmall!.netflixSans.copyWith(
        color: appTheme.gray50003,
        fontSize: 12.fSize,
      );
  static get bodySmallOnError => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onError,
        fontSize: 12.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 12.fSize,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 9.fSize,
      );
  static get bodySmallPrimaryContainer12 => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 12.fSize,
      );
  static get bodySmallSkModernistBlack900 =>
      theme.textTheme.bodySmall!.skModernist.copyWith(
        color: appTheme.black900.withOpacity(0.4),
        fontSize: 12.fSize,
      );
  static get bodySmallSkModernistBlack90012 =>
      theme.textTheme.bodySmall!.skModernist.copyWith(
        color: appTheme.black900.withOpacity(0.7),
        fontSize: 12.fSize,
      );
  // Label text style
  static get labelLargeBluegray40001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 13.fSize,
      );
  static get labelLargeGray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray900,
        fontSize: 13.fSize,
      );
  static get labelLargeGray90002 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray90002,
        fontSize: 13.fSize,
      );
  static get labelLargePlusJakartaSansBluegray40001 =>
      theme.textTheme.labelLarge!.plusJakartaSans.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 13.fSize,
      );
  static get labelLargePlusJakartaSansBluegray40001Medium =>
      theme.textTheme.labelLarge!.plusJakartaSans.copyWith(
        color: appTheme.blueGray40001,
        fontWeight: FontWeight.w500,
      );
  static get labelLargePlusJakartaSansPrimary =>
      theme.textTheme.labelLarge!.plusJakartaSans.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 13.fSize,
      );
  static get labelLargeProximaNova2PrimaryContainer =>
      theme.textTheme.labelLarge!.proximaNova2.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 13.fSize,
      );
  static get labelLargeSFProTextGray90003 =>
      theme.textTheme.labelLarge!.sFProText.copyWith(
        color: appTheme.gray90003,
        fontSize: 13.fSize,
      );
  // Title text style
  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 22.fSize,
      );
  static get titleLargeOnPrimary21 => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 21.fSize,
      );
  static get titleMediumAirbnbCerealAppOnPrimary =>
      theme.textTheme.titleMedium!.airbnbCerealApp.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumPlusJakartaSansGray90002 =>
      theme.textTheme.titleMedium!.plusJakartaSans.copyWith(
        color: appTheme.gray90002,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 19.fSize,
      );
  static get titleMediumIndigoContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.indigo900.withOpacity(1),
        fontSize: 19.fSize,
      );
  static get titleSmallBluegray40001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray40001,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallGray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90002,
      );
  static get titleSmallGray90002SemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90002,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPrimaryContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  static get titleSmallProximaNova2PrimaryContainer =>
      theme.textTheme.titleSmall!.proximaNova2.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
        fontSize: 15.fSize,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get airbnbCerealApp {
    return copyWith(
      fontFamily: 'Airbnb Cereal App',
    );
  }

  TextStyle get plusJakartaSans {
    return copyWith(
      fontFamily: 'Plus Jakarta Sans',
    );
  }

  TextStyle get sFProText {
    return copyWith(
      fontFamily: 'SF Pro Text',
    );
  }

  // ignore: unused_element
  TextStyle get nunitoSans {
    return copyWith(
      fontFamily: 'Nunito Sans',
    );
  }

  TextStyle get netflixSans {
    return copyWith(
      fontFamily: 'Netflix Sans',
    );
  }

  TextStyle get proximaNova2 {
    return copyWith(
      fontFamily: 'ProximaNova2',
    );
  }

  TextStyle get proximaNova {
    return copyWith(
      fontFamily: 'Proxima Nova',
    );
  }

  TextStyle get skModernist {
    return copyWith(
      fontFamily: 'Sk-Modernist',
    );
  }
}
