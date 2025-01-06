import 'package:http/http.dart' as http;

class Student {
  final String name;
  final String email;
  final String password;
  final int age;
  final bool gender;
  final String nationality;
  final String status;
  final String fieldOfStudy;
  final int hoursOfWorkExperience;
  final int hoursOfVolunteeringExperience;
  final int languageLevel;
  final String languageTest;
  final String languageLevelLetter;
  final String lookingForScholarship;
  final String currentResidency;
  final String researchProposal;
  final String lastDegreeAcquired;

  Student({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.status,
    required this.fieldOfStudy,
    required this.hoursOfWorkExperience,
    required this.hoursOfVolunteeringExperience,
    required this.languageTest,
    required this.languageLevel,
    required this.languageLevelLetter,
    required this.lookingForScholarship,
    required this.currentResidency,
    required this.researchProposal,
    required this.lastDegreeAcquired,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'password': String password,
        'age': int age,
        'email': String email,
        'gender': bool gender,
        'nationality': String nationality,
        'status': String status,
        'fieldOfStudy': String fieldOfStudy,
        'hoursOfWorkExperience': int hoursOfWorkExperience,
        'hoursOfVolunteeringExperience': int hoursOfVolunteeringExperience,
        'languageTest': String languageTest,
        'languageLevel': int languageLevel,
        'languageLevelLetter': String languageLevelLetter,
        'lookingForScholarship': String lookingForScholarship,
        'currentResidency': String currentResidency,
        'researchProposal': String researchProposal,
        'lastDegreeAcquired': String lastDegreeAcquired,
             
      } =>
        Student(
          name: name, 
          email: email,
          password: password,
          age: age,
          gender: gender,
          nationality: nationality,
          status: status,
          fieldOfStudy: fieldOfStudy,
          hoursOfWorkExperience: hoursOfWorkExperience,
          hoursOfVolunteeringExperience: hoursOfVolunteeringExperience,
          languageTest: languageTest,
          languageLevel: languageLevel,
          languageLevelLetter: languageLevelLetter,
          lookingForScholarship: lookingForScholarship,
          currentResidency: currentResidency,
          researchProposal: researchProposal,
          lastDegreeAcquired: lastDegreeAcquired,

        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
