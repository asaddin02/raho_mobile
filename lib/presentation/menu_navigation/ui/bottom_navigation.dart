import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/menu_navigation/states/cubit/bottom_navigation/bottom_navigation_cubit.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;

  const BottomNavigation({super.key, required this.child});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationCubit(),
      child: BottomNavigationContent(child: widget.child),
    );
  }
}

class BottomNavigationContent extends StatelessWidget {
  final Widget child;

  const BottomNavigationContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: child,
      bottomNavigationBar:
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusLarge),
                    topRight: Radius.circular(AppSizes.radiusLarge),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                      blurRadius: AppSizes.radiusLarge,
                      spreadRadius: 0,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.radiusLarge),
                    topRight: Radius.circular(AppSizes.radiusLarge),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: AppSizes.paddingMedium,
                      bottom: AppSizes.paddingSmall,
                      left: AppSizes.paddingSmall,
                      right: AppSizes.paddingSmall,
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCustomNavItem(
                            context: context,
                            icon: Icons.home_rounded,
                            label: l10n.dashboardBottomNavText,
                            isSelected: state.currentIndex == 0,
                            onTap: () {
                              context.read<BottomNavigationCubit>().setIndex(0);
                              context.go(AppRoutes.dashboard.path);
                            },
                          ),
                          _buildCustomNavItem(
                            context: context,
                            icon: FontAwesomeIcons.moneyBills,
                            label: l10n.transactionBottomNavText,
                            isSelected: state.currentIndex == 1,
                            onTap: () {
                              context.read<BottomNavigationCubit>().setIndex(1);
                              context.go(AppRoutes.transaction.path);
                            },
                          ),
                          _buildCustomNavItem(
                            context: context,
                            icon: Icons.history_rounded,
                            label: l10n.therapyBottomNavText,
                            isSelected: state.currentIndex == 2,
                            onTap: () {
                              context.read<BottomNavigationCubit>().setIndex(2);
                              context.go(AppRoutes.therapy.path);
                            },
                          ),
                          _buildCustomNavItem(
                            context: context,
                            icon: Icons.person_rounded,
                            label: l10n.profileBottomNavText,
                            isSelected: state.currentIndex == 3,
                            onTap: () {
                              context.read<BottomNavigationCubit>().setIndex(3);
                              context.go(AppRoutes.profile.path);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }

  Widget _buildCustomNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          highlightColor: theme.colorScheme.primary.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.paddingSmall,
              horizontal: AppSizes.paddingMedium,
            ),
            margin: EdgeInsets.symmetric(horizontal: AppSizes.marginTiny),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(
                    isSelected ? AppSizes.paddingSmall : AppSizes.paddingTiny,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    color: isSelected
                        ? theme.colorScheme.primary.withValues(alpha: 0.15)
                        : Colors.transparent,
                  ),
                  child: Icon(
                    icon,
                    size: icon == FontAwesomeIcons.moneyBills ? 18 : 22,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: AppSizes.spacingTiny),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: AppTextStyle.supportText
                      .withWeight(
                        isSelected
                            ? AppFontWeight.semiBold
                            : AppFontWeight.regular,
                      )
                      .withColor(
                        isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                      ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(top: 4),
                  height: 2,
                  width: isSelected ? 20 : 0,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
