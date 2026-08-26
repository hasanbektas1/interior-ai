import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_links.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/enums/app_assets.dart';
import 'package:interior_ai/core/helpers/app_link_launcher.dart';
import 'package:interior_ai/app/features/presentation/credits/cubit/credits_cubit/credits_cubit.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_cubit.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_state.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_confirmation_dialog.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_copied_snackbar.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_premium_banner.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_section_label.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_tile.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_user_id_tile.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:interior_ai/core/helpers/app_rate.dart';
import 'package:interior_ai/core/helpers/app_share.dart';
import 'package:interior_ai/core/widgets/snackbar/app_snackbar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsViewBody();
  }
}

class _SettingsViewBody extends StatelessWidget {
  const _SettingsViewBody();

  void _onCopyUserId(BuildContext context) {
    final userId = context.read<SettingsCubit>().state.userId;
    if (userId.isEmpty) return;
    Clipboard.setData(ClipboardData(text: userId));
    context.read<SettingsCubit>().markUserIdCopied();
    SettingsCopiedSnackBar.show(context);
  }

  Future<void> _onRestorePurchases(BuildContext context) async {
    final ok = await context.read<CreditsCubit>().restore();
    if (!context.mounted) return;
    if (ok) {
      SettingsConfirmationDialog.show(
        context,
        AppStrings.settingsPurchaseRestored,
      );
    } else {
      AppSnackBar.show(AppStrings.restoreFailed);
    }
  }

  void _onGiveFeedback(BuildContext context) {
    AppLinkLauncher.open(AppLinks.feedbackMailto);
  }

  void _onRateUs(BuildContext context) {
    AppRate.request();
  }

  void _onShareApp(BuildContext context) {
    AppShare.app(context);
  }

  void _openPaywall(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const PaywallView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ghostWhite,
      appBar: AppBar(
        backgroundColor: AppColors.ghostWhite,
        surfaceTintColor: AppColors.ghostWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).maybePop(),
          child: Icon(
            Icons.chevron_left_rounded,
            color: AppColors.smokyBlack,
            size: context.width32,
          ),
        ),
        title: const Text(
          AppStrings.settingsTitle,
          style: TextStyle(
            color: AppColors.smokyBlack,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.width20,
              context.height8,
              context.width20,
              context.height24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!state.isPremium) ...[
                  SettingsPremiumBanner(onTap: () => _openPaywall(context)),
                  SizedBox(height: context.height24),
                ],
                const SettingsSectionLabel(label: AppStrings.settingsSupport),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: AppAsset.settingsIconRateUs,
                  label: AppStrings.settingsRateUs,
                  onTap: () => _onRateUs(context),
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: AppAsset.settingsIconShareApp,
                  label: AppStrings.settingsShareApp,
                  onTap: () => _onShareApp(context),
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: AppAsset.settingsIconFeedback,
                  label: AppStrings.settingsGiveFeedback,
                  onTap: () => _onGiveFeedback(context),
                ),
                SizedBox(height: context.height24),
                const SettingsSectionLabel(label: AppStrings.settingsGeneral),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: AppAsset.settingsIconPrivacy,
                  label: AppStrings.settingsPrivacyPolicy,
                  onTap: () => AppLinkLauncher.open(AppLinks.privacyPolicy),
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: AppAsset.settingsIconTerms,
                  label: AppStrings.settingsTermsOfUse,
                  onTap: () => AppLinkLauncher.open(AppLinks.termsOfUse),
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: AppAsset.settingsIconRestore,
                  label: AppStrings.settingsRestorePurchases,
                  showChevron: false,
                  onTap: () => _onRestorePurchases(context),
                ),
                SizedBox(height: context.height20),
                SettingsUserIdTile(
                  userId: state.userId,
                  isCopied: state.isUserIdCopied,
                  onCopy: () => _onCopyUserId(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
