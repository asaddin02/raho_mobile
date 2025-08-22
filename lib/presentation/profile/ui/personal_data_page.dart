import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/core/utils/helper.dart';
import 'package:raho_member_apps/core/utils/loading.dart';
import 'package:raho_member_apps/data/models/profile.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/profile/states/profile/profile_bloc.dart';
import 'package:raho_member_apps/presentation/profile/ui/widget/profile_avatar_widget.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';
import 'package:raho_member_apps/presentation/widgets/snackbar_toast.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  String? _cachedImage;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      dobController.text = formattedDate;

      final now = DateTime.now();
      int age = now.year - picked.year;
      if (now.month < picked.month ||
          (now.month == picked.month && now.day < picked.day)) {
        age--;
      }
      ageController.text = age.toString();
    }
  }

  late String name;
  late String partnerName;
  late String noId;
  late ValueNotifier<String> genderController;
  late TextEditingController nikController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController dobController;
  late TextEditingController ageController;
  late TextEditingController noHPController;

  @override
  void initState() {
    super.initState();
    name = "";
    partnerName = "";
    noId = "";
    nikController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    dobController = TextEditingController();
    ageController = TextEditingController();
    noHPController = TextEditingController();
    genderController = ValueNotifier<String>("Pria");
  }

  @override
  void dispose() {
    super.dispose();
    nikController.dispose();
    addressController.dispose();
    cityController.dispose();
    dobController.dispose();
    ageController.dispose();
    genderController.dispose();
    noHPController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final loading = Loading(context: context);

    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfile()),
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            name = state.profile.name ?? '-';
            partnerName = state.profile.partnerName ?? '-';
            noId = state.profile.noId ?? '-';
            nikController.text = state.profile.nik ?? '-';
            addressController.text = state.profile.address ?? '-';
            cityController.text = state.profile.city ?? '-';
            dobController.text = state.profile.dob ?? '-';
            ageController.text = state.profile.age ?? '-';
            genderController.value = state.profile.gender ?? '-';
            noHPController.text =
                state.profile.noHpWa?.replaceAll('-', '') ?? '-';
            _cachedImage = state.profile.profileImage ?? '';
          } else if (state is ProfileUpdateSuccess) {
            AppNotification.success(
              context,
              state.messageCode,
              duration: NotificationDuration.medium,
            );
            context.read<ProfileBloc>().add(ToggleEditMode());
          } else if (state is ProfileError) {
            AppNotification.error(
              context,
              state.messageCode,
              duration: NotificationDuration.medium,
            );
          }
        },
        child: BackdropApps(
          child: Padding(
            padding: EdgeInsets.only(
              top: AppSizes.spacingXl + AppSizes.spacingMedium,
              left: AppSizes.paddingMedium,
              right: AppSizes.paddingMedium,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(AppSizes.paddingMedium),
                  width: double.infinity,
                  height: 32,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            padding: EdgeInsets.all(AppSizes.paddingSmall),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(51),
                              borderRadius: BorderRadius.circular(
                                AppSizes.radiusSmall,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Theme.of(context).colorScheme.onSurface,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          l10n.personalDataMenuTitle,
                          style: AppTextStyle.title.withColor(
                            Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocConsumer<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return _buildContent(context, colorScheme, l10n);
                    },
                    listener: (BuildContext context, ProfileState state) {
                      if (state is ProfileLoading) {
                        loading.show();
                      }
                      loading.dismiss();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: AppSizes.paddingLarge),
      child: Column(
        children: [
          _buildCard(
            child: _buildProfileHeader(colorScheme),
            colorScheme: colorScheme,
          ),
          SizedBox(height: AppSizes.spacingLarge),
          _buildCard(
            child: _buildPersonalDataForm(colorScheme, l10n),
            colorScheme: colorScheme,
          ),
          SizedBox(height: AppSizes.spacingLarge),
          _buildActionButtons(colorScheme, l10n),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child, required ColorScheme colorScheme}) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.all(AppSizes.paddingLarge),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ColorScheme colorScheme) {
    return Row(
      children: [
        Hero(
          tag: 'profile_avatar',
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: 0.2),
                  colorScheme.primary.withValues(alpha: 0.1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: Colors.transparent,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded || state is ProfileEditMode) {
                    return ProfileAvatarWidget(
                      base64Image: _cachedImage,
                    );
                  }
                  return CircleAvatar(
                    radius: 34,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    backgroundImage: const AssetImage(
                      "assets/images/person.jpg",
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.spacingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyle.subtitle.withColor(colorScheme.onSurface),
              ),
              SizedBox(height: AppSizes.spacingTiny),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingSmall,
                  vertical: AppSizes.paddingTiny,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: colorScheme.primary,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      partnerName,
                      style: AppTextStyle.caption.withColor(
                        colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.spacingTiny),
              Text(noId, style: AppTextStyle.caption.withColor(AppColor.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalDataForm(
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final bool isEdit = state is ProfileEditMode;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(l10n.personalSectionTitle, colorScheme),
            SizedBox(height: AppSizes.spacingMedium),
            _buildAnimatedTextField(
              label: l10n.fieldLabelNIK,
              controller: nikController,
              icon: Icons.credit_card,
              readOnly: !isEdit,
              colorScheme: colorScheme,
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _buildAnimatedTextField(
              label: l10n.fieldLabelAddress,
              controller: addressController,
              icon: Icons.home,
              readOnly: !isEdit,
              maxLines: 2,
              colorScheme: colorScheme,
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _buildAnimatedTextField(
              label: l10n.fieldLabelCity,
              controller: cityController,
              icon: Icons.location_city,
              readOnly: !isEdit,
              colorScheme: colorScheme,
            ),
            SizedBox(height: AppSizes.spacingMedium),
            Row(
              children: [
                Expanded(
                  child: _buildDateField(
                    label: l10n.fieldLabelDateOfBirth,
                    controller: dobController,
                    isEdit: isEdit,
                    colorScheme: colorScheme,
                  ),
                ),
                SizedBox(width: AppSizes.spacingMedium),
                Expanded(
                  child: _buildAnimatedTextField(
                    label: l10n.fieldLabelAge,
                    controller: ageController,
                    icon: Icons.cake,
                    readOnly: true,
                    suffixText: l10n.fieldSuffixYears,
                    colorScheme: colorScheme,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _buildGenderDropdown(
              l10n,
              label: l10n.fieldLabelGender,
              isEdit: isEdit,
              colorScheme: colorScheme,
            ),
            SizedBox(height: AppSizes.spacingMedium),
            _buildPhoneField(
              label: l10n.fieldLabelPhone,
              isEdit: isEdit,
              colorScheme: colorScheme,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorScheme.primary, colorScheme.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
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

  Widget _buildAnimatedTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool readOnly,
    required ColorScheme colorScheme,
    int maxLines = 1,
    String? suffixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.body.withColor(colorScheme.onSurface)),
        SizedBox(height: AppSizes.spacingTiny),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          style: AppTextStyle.body.withColor(colorScheme.onSurface),
          decoration: InputDecoration(
            prefixIcon: Container(
              margin: EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
              child: Icon(icon, color: colorScheme.primary, size: 20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            filled: true,
            fillColor: readOnly
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                : colorScheme.surface.withValues(alpha: 0.8),
            contentPadding: EdgeInsets.all(AppSizes.paddingMedium),
            suffixText: suffixText,
            suffixStyle: AppTextStyle.caption.withColor(colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required bool isEdit,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.body.withColor(colorScheme.onSurface)),
        SizedBox(height: AppSizes.spacingTiny),
        TextFormField(
          controller: controller,
          readOnly: true,
          style: AppTextStyle.body.withColor(colorScheme.onSurface),
          onTap: isEdit ? () => _selectDate(context) : null,
          decoration: InputDecoration(
            prefixIcon: Container(
              margin: EdgeInsets.all(AppSizes.paddingSmall),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
              child: Icon(
                CupertinoIcons.calendar,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            filled: true,
            fillColor: !isEdit
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                : colorScheme.surface.withValues(alpha: 0.8),
            contentPadding: EdgeInsets.all(AppSizes.paddingMedium),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(
    AppLocalizations l10n, {
    required String label,
    required bool isEdit,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.body.withColor(colorScheme.onSurface)),
        SizedBox(height: AppSizes.spacingTiny),
        ValueListenableBuilder<String>(
          valueListenable: genderController,
          builder: (context, value, child) {
            return GestureDetector(
              onTap: isEdit
                  ? () => _showGenderDropdown(context, colorScheme, l10n)
                  : null,
              child: Container(
                padding: EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  color: !isEdit
                      ? colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        )
                      : colorScheme.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  border: isEdit
                      ? Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.5),
                          width: 1,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: AppSizes.paddingMedium),
                      padding: EdgeInsets.all(AppSizes.paddingSmall),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppSizes.radiusTiny,
                        ),
                      ),
                      child: Icon(
                        value == "Pria" ? Icons.male : Icons.female,
                        color: colorScheme.primary,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        value.isEmpty ? l10n.genderSelectLabel : value,
                        style: AppTextStyle.body.withColor(
                          value.isEmpty
                              ? colorScheme.onSurface.withValues(alpha: 0.6)
                              : colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (isEdit)
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: colorScheme.onSurface,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showGenderDropdown(
    BuildContext context,
    ColorScheme colorScheme,
    AppLocalizations l10n,
  ) {
    final List<String> genderOptions = [l10n.genderMale, l10n.genderFemale];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.radiusLarge),
              topRight: Radius.circular(AppSizes.radiusLarge),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: AppSizes.paddingMedium),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.all(AppSizes.paddingLarge),
                child: Text(
                  l10n.genderSelectTitle,
                  style: AppTextStyle.title.withColor(colorScheme.onSurface),
                ),
              ),

              // Options
              ...genderOptions.map((gender) {
                final isSelected = genderController.value == gender;
                return ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(AppSizes.paddingSmall),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(
                        alpha: isSelected ? 0.2 : 0.1,
                      ),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                    child: Icon(
                      gender == "Pria" ? Icons.male : Icons.female,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    gender,
                    style: AppTextStyle.body.withColor(
                      isSelected ? colorScheme.primary : colorScheme.onSurface,
                    ),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check, color: colorScheme.primary)
                      : null,
                  onTap: () {
                    genderController.value = gender;
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: AppSizes.paddingLarge),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhoneField({
    required String label,
    required bool isEdit,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.body.withColor(colorScheme.onSurface)),
        SizedBox(height: AppSizes.spacingTiny),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: !isEdit
                    ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                    : colorScheme.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.radiusMedium),
                  bottomLeft: Radius.circular(AppSizes.radiusMedium),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(AppSizes.paddingTiny),
                    decoration: BoxDecoration(
                      color: AppColor.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                    child: Icon(Icons.phone, color: AppColor.green, size: 16),
                  ),
                  SizedBox(width: AppSizes.spacingSmall),
                  Text(
                    commonPhonePrefixes[2],
                    style: AppTextStyle.body.withColor(colorScheme.onSurface),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: colorScheme.onSurface,
                    size: 16,
                  ),
                ],
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: noHPController,
                readOnly: !isEdit,
                style: AppTextStyle.body.withColor(colorScheme.onSurface),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppSizes.radiusMedium),
                      bottomRight: Radius.circular(AppSizes.radiusMedium),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppSizes.radiusMedium),
                      bottomRight: Radius.circular(AppSizes.radiusMedium),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppSizes.radiusMedium),
                      bottomRight: Radius.circular(AppSizes.radiusMedium),
                    ),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: !isEdit
                      ? colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        )
                      : colorScheme.surface.withValues(alpha: 0.8),
                  contentPadding: EdgeInsets.all(AppSizes.paddingMedium),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(ColorScheme colorScheme, AppLocalizations l10n) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final bool isEdit = state is ProfileEditMode;

        return Row(
          children: [
            if (isEdit) ...[
              Expanded(
                child: _buildAnimatedButton(
                  text: l10n.personalDataCancelButton,
                  isPrimary: false,
                  onPressed: () {
                    context.read<ProfileBloc>().add(ToggleEditMode());
                  },
                  colorScheme: colorScheme,
                ),
              ),
              SizedBox(width: AppSizes.spacingMedium),
            ],
            Expanded(
              child: _buildAnimatedButton(
                text: isEdit
                    ? l10n.personalDataSaveButton
                    : l10n.personalDataEditButton,
                isPrimary: true,
                onPressed: () {
                  if (isEdit) {
                    // Prepare update request
                    final updateRequest = UpdateProfileRequest(
                      nik: nikController.text,
                      street: addressController.text,
                      city: cityController.text,
                      dob: dobController.text,
                      sex: genderController.value == "Pria" ? "1" : "2",
                      mobile: noHPController.text,
                    );

                    // Send update event
                    context.read<ProfileBloc>().add(
                      UpdateProfile(request: updateRequest),
                    );
                  } else {
                    // Toggle to edit mode
                    context.read<ProfileBloc>().add(ToggleEditMode());
                  }
                },
                colorScheme: colorScheme,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
    required ColorScheme colorScheme,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        elevation: isPrimary ? 8 : 0,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        shadowColor: isPrimary
            ? colorScheme.primary.withValues(alpha: 0.3)
            : null,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSizes.paddingLarge),
            decoration: BoxDecoration(
              gradient: isPrimary
                  ? LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.primary.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: !isPrimary
                  ? Border.all(color: colorScheme.primary, width: 2)
                  : null,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Center(
              child: Text(
                text,
                style: AppTextStyle.subtitle.withColor(
                  isPrimary ? colorScheme.onPrimary : colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
