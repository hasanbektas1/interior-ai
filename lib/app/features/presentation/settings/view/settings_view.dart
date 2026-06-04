import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';
import 'package:interior_ai/app/common/constants/app_strings.dart';
import 'package:interior_ai/app/common/get_it/get_it.dart';
import 'package:interior_ai/app/features/presentation/paywall/view/paywall_view.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_cubit.dart';
import 'package:interior_ai/app/features/presentation/settings/cubit/settings_state.dart';
import 'package:interior_ai/app/common/widgets/dialogs/rate_us_dialog.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_confirmation_dialog.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_premium_banner.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_section_label.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_tile.dart';
import 'package:interior_ai/app/features/presentation/settings/widgets/settings_user_id_tile.dart';
import 'package:interior_ai/core/extensions/build_context_extensions.dart';
import 'package:share_plus/share_plus.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>.value(
      value: getIt<SettingsCubit>(),
      child: const _SettingsViewBody(),
    );
  }
}

class _SettingsViewBody extends StatelessWidget {
  const _SettingsViewBody();

  void _onCopyUserId(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: AppStrings.sampleUserId));
    SettingsConfirmationDialog.show(context, AppStrings.settingsCopiedToClipboard);
  }

  void _onRestorePurchases(BuildContext context) {
    SettingsConfirmationDialog.show(context, AppStrings.settingsPurchaseRestored);
  }

  void _onRateUs(BuildContext context) {
    RateUsDialog.show(context, (_) => Navigator.of(context).maybePop());
  }

  void _onShareApp() {
    Share.share(AppStrings.settingsShareMessage);
  }

  void _openPaywall(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PaywallView()),
    );
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
                  icon: Icons.star_rounded,
                  label: AppStrings.settingsRateUs,
                  onTap: () => _onRateUs(context),
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: Icons.send_rounded,
                  label: AppStrings.settingsShareApp,
                  onTap: _onShareApp,
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: Icons.mail_rounded,
                  label: AppStrings.settingsGiveFeedback,
                  onTap: () {},
                ),
                SizedBox(height: context.height24),
                const SettingsSectionLabel(label: AppStrings.settingsGeneral),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: Icons.remove_red_eye_rounded,
                  label: AppStrings.settingsPrivacyPolicy,
                  onTap: () {},
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: Icons.description_rounded,
                  label: AppStrings.settingsTermsOfUse,
                  onTap: () {},
                ),
                SizedBox(height: context.height12),
                SettingsTile(
                  icon: Icons.restore_rounded,
                  label: AppStrings.settingsRestorePurchases,
                  showChevron: false,
                  onTap: () => _onRestorePurchases(context),
                ),
                SizedBox(height: context.height20),
                SettingsUserIdTile(
                  userId: AppStrings.sampleUserId,
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
