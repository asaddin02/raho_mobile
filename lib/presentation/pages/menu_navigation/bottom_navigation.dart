import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/bloc/user/user_bloc.dart';
import 'package:raho_mobile/core/constants/route_constant.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/cubit/bottom_navigation/bottom_navigation_cubit.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;

  const BottomNavigation({super.key, required this.child});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<UserBloc>().add(FetchProfile());
    });
    super.initState();
  }

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
    return Scaffold(
      body: child,
      bottomNavigationBar:
          BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color:AppColor.grey.withValues(alpha: 0.5),
                  spreadRadius: 0.5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Material(
              color: AppColor.white,
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: AppColor.white,
                    currentIndex: state.currentIndex,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: AppColor.black,
                    unselectedItemColor: AppColor.grey,
                    selectedFontSize: 10,
                    unselectedFontSize: 10,
                    onTap: (index) {
                      context.read<BottomNavigationCubit>().setIndex(index);
                      switch (index) {
                        case 0:
                          context.go(RouteApp.dashboard);
                          break;
                        case 1:
                          context.go(RouteApp.transaction);
                          break;
                        case 2:
                          context.go(RouteApp.history);
                          break;
                        case 3:
                          context.go(RouteApp.profile);
                          break;
                      }
                    },
                    items: [
                      _buildNavItem(
                        icon: Icons.home,
                        label: "Beranda",
                        size: 24,
                        isSelected: state.currentIndex == 0,
                      ),
                      _buildNavItem(
                        icon: FontAwesomeIcons.moneyBills,
                        label: "Transaksi",
                        size: 20,
                        isSelected: state.currentIndex == 1,
                      ),
                      _buildNavItem(
                        icon: Icons.history,
                        label: "Riwayat",
                        size: 24,
                        isSelected: state.currentIndex == 2,
                      ),
                      _buildNavItem(
                        icon: Icons.person,
                        label: "Saya",
                        size: 24,
                        isSelected: state.currentIndex == 3,
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

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required double size,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: size,
            color: isSelected ? AppColor.black : AppColor.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: isSelected
                ? AppFontStyle.s10.regular.black
                : AppFontStyle.s10.regular.grey,
          ),
        ],
      ),
      label: '',
    );
  }
}
