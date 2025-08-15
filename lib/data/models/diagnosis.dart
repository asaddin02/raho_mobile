class DiagnosisModel {
  final String status;
  final String code;
  final String name;
  final String partnerName;
  final String noId;
  final String note;
  final String currentIllness;
  final String previousIllness;
  final String socialHabit;
  final String treatmentHistory;
  final String physicalExamination;
  final String profileImage;

  DiagnosisModel({
    required this.status,
    required this.code,
    required this.name,
    required this.partnerName,
    required this.noId,
    required this.note,
    required this.currentIllness,
    required this.previousIllness,
    required this.socialHabit,
    required this.treatmentHistory,
    required this.physicalExamination,
    required this.profileImage,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return DiagnosisModel(
      status: json['status'] ?? '',
      code: data['code'] ?? '',
      name: data['name'] ?? '',
      partnerName: data['partner_name'] ?? '',
      noId: data['no_id'] ?? '',
      note: data['note'] ?? '-',
      currentIllness: data['current_illness'] ?? '-',
      previousIllness: data['previous_illness'] ?? '-',
      socialHabit: data['social_habit'] ?? '-',
      treatmentHistory: data['treatment_history'] ?? '-',
      physicalExamination: data['physical_examination'] ?? '-',
      profileImage: data['profile_image'] ?? '',
    );
  }
}
