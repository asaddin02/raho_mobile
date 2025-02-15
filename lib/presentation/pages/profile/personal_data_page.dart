import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:raho_mobile/bloc/user/user_bloc.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/core/utils/loading.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';
import 'package:raho_mobile/presentation/widgets/custom_dropdown.dart';

class PersonalDataPage extends StatefulWidget {
  const PersonalDataPage({super.key});

  @override
  State<PersonalDataPage> createState() => _PersonalDataPageState();
}

class _PersonalDataPageState extends State<PersonalDataPage> {
  Future<void> _selectDate(BuildContext context, DateTime dateTime) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      dobController.text = formattedDate;
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
    nikController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    dobController = TextEditingController();
    ageController = TextEditingController();
    genderController = ValueNotifier<String>("");
    noHPController = TextEditingController();
    _initPersonalData();
  }

  void _initPersonalData() {
    final Loading loading = Loading(context: context);
    final currentState = context.read<UserBloc>().state;
    if (currentState is UserLoading) {
      loading.show();
    } else {
      loading.dismiss();
    }
    if (currentState is UserLoadedProfile || currentState.profile != null) {
      name = currentState.profile!.name;
      partnerName = currentState.profile!.partnerName;
      noId = currentState.profile!.noId;
      nikController = TextEditingController(text: currentState.profile!.nik);
      addressController =
          TextEditingController(text: currentState.profile!.address);
      cityController = TextEditingController(text: currentState.profile!.city);
      dobController = TextEditingController(text: currentState.profile!.dob);
      ageController = TextEditingController(text: currentState.profile!.age);
      genderController = ValueNotifier(currentState.profile!.gender);
      noHPController =
          TextEditingController(text: currentState.profile!.noHpWa);
    }
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
    return BackgroundWhiteBlack(
        child: Padding(
      padding: EdgeInsets.only(top: 48, left: 12, right: 12),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
            width: Screen.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColor.white,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Data Pribadi",
                    textAlign: TextAlign.center,
                    style: AppFontStyle.s20.semibold.white,
                  ),
                )
              ],
            ),
          ),
          BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state.profile == null) {
                context.read<UserBloc>().add(FetchProfile());
              }
            },
            builder: (context, state) {
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      width: Screen.width,
                      margin: EdgeInsets.only(bottom: 12, left: 4, right: 4),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.black.withValues(alpha: 0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                            )
                          ]),
                      child: state is UserError
                          ? _buildError()
                          : _buildSuccess(state: state),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    ));
  }

  Widget _buildError() {
    return Center(
      child: GestureDetector(
        onTap: () => context.read<UserBloc>().add(FetchProfile()),
        child: Column(
          children: [
            Icon(
              Icons.refresh,
              color: AppColor.primary,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Try load again",
              style: AppFontStyle.s16.semibold.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess({required UserState state}) {
    bool fReadOnly = !state.isEdit;
    TextStyle styleText = state.isEdit
        ? AppFontStyle.s16.bold.white
        : AppFontStyle.s16.bold.black;
    Color buttonColor = state.isEdit ? AppColor.black2 : AppColor.white;
    String text = state.isEdit ? "Simpan" : "Edit";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/person.jpg"),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppFontStyle.s14.semibold.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColor.primary,
                      size: 14,
                    ),
                    Text(
                      partnerName,
                      style: AppFontStyle.s12.regular.black,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  noId,
                  style: AppFontStyle.s12.regular.grey,
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "NIK",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: fReadOnly,
          controller: nikController,
          style: AppFontStyle.s12.regular.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Alamat",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: fReadOnly,
          maxLines: 2,
          controller: addressController,
          style: AppFontStyle.s12.regular.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Kota/Kabupaten",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: fReadOnly,
          controller: cityController,
          style: AppFontStyle.s12.regular.black,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: AppColor.grey)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tanggal Lahir",
                    style: AppFontStyle.s14.semibold.black,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    readOnly: true,
                    style: AppFontStyle.s12.regular.black,
                    controller: dobController,
                    onTap: () {
                      if (state.isEdit) {
                        _selectDate(
                            context, formatToDefault(dobController.text));
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.calendar),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColor.grey)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColor.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColor.grey)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Usia",
                    style: AppFontStyle.s14.semibold.black,
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    readOnly: true,
                    controller: ageController,
                    style: AppFontStyle.s12.regular.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Tahun",
                              style: AppFontStyle.s12.regular.black,
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.only(right: 40, left: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColor.grey)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColor.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: AppColor.grey)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Jenis Kelamin",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        AbsorbPointer(
          absorbing: !state.isEdit,
          child: CustomDropdown(
            items: [
              "Pria",
              "Wanita",
            ],
            onSelect: (value) {
              genderController.value = value;
            },
            maxHeight: 150,
            child: ValueListenableBuilder(
                valueListenable: genderController,
                builder: (context, value, child) {
                  return Container(
                    width: Screen.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColor.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value,
                          style: AppFontStyle.s12.regular.black,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColor.black,
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Nomor WhatsApp",
          style: AppFontStyle.s14.semibold.black,
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            CustomDropdown(
              items: commonPhonePrefixes,
              onSelect: (value) {
                print(value);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6)),
                    border: Border(
                        right: BorderSide.none,
                        top: BorderSide(color: AppColor.grey),
                        left: BorderSide(color: AppColor.grey),
                        bottom: BorderSide(color: AppColor.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      commonPhonePrefixes[2],
                      style: AppFontStyle.s12.regular.black,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: AppColor.black,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TextFormField(
              readOnly: fReadOnly,
              controller: noHPController,
              style: AppFontStyle.s12.regular.black,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                    borderSide: BorderSide(color: AppColor.grey)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                    borderSide: BorderSide(color: AppColor.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                    borderSide: BorderSide(color: AppColor.grey)),
              ),
            ))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            if (state.isEdit) ...[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<UserBloc>().add(ToggleEdit());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.white,
                        border: Border.all(color: AppColor.black)),
                    child: Text(
                      "Batalkan",
                      style: AppFontStyle.s16.bold.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (state.isEdit) {
                    context.read<UserBloc>().add(EditPersonalData(
                        nik: nikController.text,
                        address: addressController.text,
                        city: cityController.text,
                        dob: dobController.text,
                        gender: genderController.value,
                        noHpWa: noHPController.text));
                  } else {
                    context.read<UserBloc>().add(ToggleEdit());
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: buttonColor,
                      border: Border.all(color: AppColor.black)),
                  child: Text(
                    text,
                    style: styleText,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
