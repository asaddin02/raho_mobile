import 'package:equatable/equatable.dart';

class DiagnosisModel extends Equatable {
  final String status;
  final String name;
  final String partnerName;
  final String noId;
  final String note;
  final String currentIllness;
  final String previousIllness;
  final String socialHabit;
  final String treatmentHistory;
  final String physicalExamination;

  const DiagnosisModel({
    required this.status,
    required this.name,
    required this.partnerName,
    required this.noId,
    required this.note,
    required this.currentIllness,
    required this.previousIllness,
    required this.socialHabit,
    required this.treatmentHistory,
    required this.physicalExamination,
  });

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      status: json['status'],
      name: json['data']['name'],
      partnerName: json['data']['partner_name'],
      noId: json['data']['no_id'],
      note: json['data']['note'],
      currentIllness: json['data']['current_illness'],
      previousIllness: json['data']['previous_illness'],
      socialHabit: json['data']['social_habit'],
      treatmentHistory: json['data']['treatment_history'],
      physicalExamination: json['data']['physical_examination'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        partnerName,
        noId,
        note,
        currentIllness,
        previousIllness,
        socialHabit,
        treatmentHistory,
        physicalExamination,
      ];
}
