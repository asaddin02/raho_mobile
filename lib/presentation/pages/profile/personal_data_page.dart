import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';
import 'package:raho_mobile/core/utils/helper.dart';
import 'package:raho_mobile/presentation/template/background_white_black.dart';
import 'package:raho_mobile/presentation/widgets/custom_dropdown.dart';

class PersonalDataPage extends StatelessWidget {
  PersonalDataPage({super.key});

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  final List<String> _commonPhonePrefixes = [
    "+1",
    "+44",
    "+62",
    "+91",
    "+86",
    "+81",
    "+49",
    "+33",
    "+39",
    "+55",
    "+34",
    "+61",
    "+61",
    "+52",
    "+27",
    "+7",
    "+60",
    "+63",
    "+91",
    "+971",
    "+965",
    "+974",
    "+973",
    "+971",
    "+54",
    "+53",
    "+98",
    "+234",
    "+254",
  ];

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
          Expanded(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/person.jpg"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mirza Ananta",
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
                                    "Klinik RAHO Citraland",
                                    style: AppFontStyle.s12.regular.black,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "240224014056",
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
                        maxLines: 2,
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
                                  style: AppFontStyle.s12.regular.black,
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(CupertinoIcons.calendar),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide:
                                            BorderSide(color: AppColor.grey)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide:
                                            BorderSide(color: AppColor.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide:
                                            BorderSide(color: AppColor.grey)),
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
                                            style:
                                                AppFontStyle.s12.regular.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(right: 40, left: 12),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide:
                                            BorderSide(color: AppColor.grey)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide:
                                            BorderSide(color: AppColor.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide:
                                            BorderSide(color: AppColor.grey)),
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
                      CustomDropdown(
                        items: [
                          "Pria",
                          "Wanita",
                        ],
                        onSelect: (value) {
                          print(value);
                        },
                        maxHeight: 150,
                        child: Container(
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
                                "Pria",
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
                      const SizedBox(height: 10),
                      Text(
                        "Nomor WhatsApp",
                        style: AppFontStyle.s14.semibold.black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          CustomDropdown(
                            items: _commonPhonePrefixes,
                            onSelect: (value) {
                              print(value);
                            },
                            child: Container(
                              width: Screen.width * 0.2,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                  border: Border(
                                      right: BorderSide.none,
                                      top: BorderSide(color: AppColor.grey),
                                      left: BorderSide(color: AppColor.grey),
                                      bottom:
                                          BorderSide(color: AppColor.grey))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _commonPhonePrefixes.first,
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
                      const SizedBox(height: 10),
                      Text(
                        "Nomor Ponsel Cadangan",
                        style: AppFontStyle.s14.semibold.black,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          CustomDropdown(
                            items: _commonPhonePrefixes,
                            onSelect: (value) {
                              print(value);
                            },
                            child: Container(
                              width: Screen.width * 0.2,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomLeft: Radius.circular(6)),
                                  border: Border(
                                      right: BorderSide.none,
                                      top: BorderSide(color: AppColor.grey),
                                      left: BorderSide(color: AppColor.grey),
                                      bottom:
                                          BorderSide(color: AppColor.grey))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _commonPhonePrefixes.first,
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
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.black2,
                              border: Border.all(color: AppColor.black)),
                          child: Text(
                            "Simpan",
                            style: AppFontStyle.s16.bold.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
