import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/data/repositories/user_repository.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/authentication/states/auth/auth_bloc.dart';
import 'package:raho_member_apps/presentation/profile/model/menu_item_data.dart';
import 'package:raho_member_apps/presentation/profile/states/profile/profile_bloc.dart';
import 'package:raho_member_apps/presentation/profile/ui/dialog/info_app_dialog.dart';
import 'package:raho_member_apps/presentation/profile/ui/dialog/language_dialog.dart';
import 'package:raho_member_apps/presentation/profile/ui/dialog/logout_dialog.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/theme/states/cubit/theme_cubit.dart';
import 'package:raho_member_apps/presentation/widgets/snackbar_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProfileBloc(repository: sl<UserRepository>())..add(GetProfile()),
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                _buildHeader(context, colorScheme, l10n),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingLarge,
                    ),
                    child: Column(
                      children: [
                        _buildProfileCard(context, colorScheme, l10n),
                        SizedBox(height: AppSizes.spacingLarge),
                        _buildVersionFooter(colorScheme, l10n),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingLarge,
        vertical: AppSizes.paddingMedium,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.profilePageTitle,
              style: AppTextStyle.heading2.withColor(colorScheme.onSurface),
            ),
          ),
          _buildThemeToggle(context, colorScheme, l10n),
        ],
      ),
    );
  }

  Widget _buildThemeToggle(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          borderRadius: BorderRadius.circular(AppSizes.radiusXl),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDark
                      ? CupertinoIcons.moon_fill
                      : CupertinoIcons.sun_max_fill,
                  color: const Color(0xFFE03A47),
                  size: 18,
                ),
                SizedBox(width: AppSizes.spacingTiny),
                Text(
                  isDark ? l10n.themeDarkLabel : l10n.themeLightLabel,
                  style: AppTextStyle.caption.withColor(colorScheme.onSurface),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildProfileHeader(colorScheme),
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPersonalSection(context, colorScheme, l10n),
                SizedBox(height: AppSizes.spacingXl),
                _buildSupportSection(context, colorScheme, l10n),
                SizedBox(height: AppSizes.spacingXl),
                _buildSettingsSection(context, colorScheme, l10n),
                SizedBox(height: AppSizes.spacingXl),
                _buildLogoutButton(context, colorScheme, l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final user = context.read<AuthBloc>().currentUser;

          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, profState) {
              String? b64;
              if (profState is ProfileLoaded) {
                b64 = profState.profile.profileImage;
              }

              final bytes = decodeBase64Image(b64);

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE03A47), Color(0xFFD32F2F)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFE03A47).withAlpha(77),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.surface,
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        child: ClipOval(
                          child: bytes != null
                              ? Image.memory(
                                  bytes,
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.cover,
                                  gaplessPlayback: true,
                                  filterQuality: FilterQuality.medium,
                                )
                              : Image.asset(
                                  "assets/images/person.png",
                                  width: 96,
                                  height: 96,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.spacingLarge),
                  Text(
                    user?.name ?? '',
                    style: AppTextStyle.title.withColor(colorScheme.onSurface),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.spacingSmall),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMedium,
                      vertical: AppSizes.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withAlpha(153),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                      border: Border.all(
                        color: colorScheme.outline.withAlpha(26),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      user?.id ?? '',
                      style: AppTextStyle.caption.withColor(
                        colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPersonalSection(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(l10n.personalSectionTitle, colorScheme),
        SizedBox(height: AppSizes.spacingMedium),
        _buildMenuGrid(context, colorScheme, [
          MenuItemData(
            title: l10n.personalDataMenuTitle,
            subtitle: l10n.personalDataMenuSubtitle,
            icon: CupertinoIcons.profile_circled,
            onTap: () {
              context.goNamed(AppRoutes.personalData.name);
            },
          ),
          MenuItemData(
            title: l10n.diagnosisMenuTitle,
            subtitle: l10n.diagnosisMenuSubtitle,
            icon: Icons.fact_check_outlined,
            onTap: () {
              context.goNamed(AppRoutes.myDiagnosis.name);
            },
          ),
          MenuItemData(
            title: l10n.referenceCodeMenuTitle,
            subtitle: l10n.referenceCodeMenuSubtitle,
            icon: Icons.description_outlined,
            onTap: () {
              context.goNamed(AppRoutes.referenceCode.name);
            },
          ),
        ]),
      ],
    );
  }

  Widget _buildSupportSection(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(l10n.supportSectionTitle, colorScheme),
        SizedBox(height: AppSizes.spacingMedium),
        _buildMenuGrid(context, colorScheme, [
          MenuItemData(
            title: l10n.branchLocationMenuTitle,
            subtitle: l10n.branchLocationMenuSubtitle,
            icon: CupertinoIcons.location_solid,
            onTap: () {
              context.goNamed(AppRoutes.branchLocation.name);
            },
          ),
          MenuItemData(
            title: l10n.helpMenuTitle,
            subtitle: l10n.helpMenuSubtitle,
            icon: Icons.help_outline_rounded,
            onTap: () async {
              final ctx = context;
              const phoneNumber = '6282121825600';
              final message =
                "Halo, saya butuh bantuan dengan aplikasi Raho Member.";
              final whatsappUrl = Uri.parse(
                "https://wa.me/$phoneNumber?text=$message",
              );
              final canLaunch = await canLaunchUrl(whatsappUrl);
              if (canLaunch) {
                await launchUrl(
                  whatsappUrl,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                if (ctx.mounted) {
                  AppNotification.success(
                    context,
                    l10n.whatsappOpenError,
                    duration: NotificationDuration.medium,
                  );
                }
              }
            },
          ),
        ]),
      ],
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(l10n.settingsSectionTitle, colorScheme),
        SizedBox(height: AppSizes.spacingMedium),
        _buildMenuGrid(context, colorScheme, [
          MenuItemData(
            title: l10n.languageMenuTitle,
            subtitle: l10n.languageMenuSubtitle,
            icon: Icons.language_outlined,
            onTap: () => showLanguageDialog(context, colorScheme),
          ),
          MenuItemData(
            title: l10n.aboutAppMenuTitle,
            subtitle: l10n.aboutAppMenuSubtitle,
            icon: Icons.info_outline_rounded,
            onTap: () => showAppInfoDialog(context, colorScheme),
          ),
        ]),
      ],
    );
  }

  Widget _buildSectionHeader(String title, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFFE03A47),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: AppSizes.spacingSmall),
        Text(
          title,
          style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
        ),
      ],
    );
  }

  Widget _buildMenuGrid(
    BuildContext context,
    ColorScheme colorScheme,
    List<MenuItemData> items,
  ) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: AppSizes.spacingSmall),
              child: _buildEnhancedMenuButton(
                title: item.title,
                subtitle: item.subtitle,
                icon: item.icon,
                onTap: item.onTap,
                colorScheme: colorScheme,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEnhancedMenuButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        child: Container(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE03A47).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  border: Border.all(
                    color: const Color(0xFFE03A47).withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: const Color(0xFFE03A47), size: 22),
              ),
              SizedBox(width: AppSizes.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.body.withColor(colorScheme.onSurface),
                    ),
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyle.caption.withColor(
                        colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.chevron_right,
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => LogoutDialog(),
          );
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.paddingLarge),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            border: Border.all(color: const Color(0xFFBF360C), width: 1.5),
            color: const Color(0xFFBF360C).withValues(alpha: 0.06),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_outlined,
                color: const Color(0xFFBF360C),
                size: 20,
              ),
              SizedBox(width: AppSizes.spacingSmall),
              Text(
                l10n.logoutButtonLabel,
                style: AppTextStyle.body.withColor(const Color(0xFFBF360C)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVersionFooter(ColorScheme colorScheme, AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.supportedBy,
          style: AppTextStyle.caption.withColor(
            colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: AppSizes.spacingTiny),
        Text(
          l10n.companyName,
          style: AppTextStyle.body
              .withWeight(AppFontWeight.black)
              .withColor(colorScheme.onSurface),
        ),
        SizedBox(height: AppSizes.spacingSmall),
      ],
    );
  }
}
