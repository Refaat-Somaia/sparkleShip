class Scholarship {
  final String title;
  final String description;
  final String providedBy;
  final String link;
  final int availabeSeats;
  final String applyDate;
  final String deadline;
  final bool isArchived;
  final double minimumGPA;
  final String location;
  final String fieldOfStudy;
  final int hoursOfWorkExperience;
  final int hoursOfVolunteeringExperience;
  final String languageTest;
  final String languageLevelLetter;
  final String funding;
  final String requiredDegree;
  final List<dynamic> nationalities;

  Scholarship(
      {required this.title,
      required this.description,
      required this.providedBy,
      required this.link,
      required this.availabeSeats,
      required this.applyDate,
      required this.deadline,
      required this.isArchived,
      required this.minimumGPA,
      required this.location,
      required this.fieldOfStudy,
      required this.hoursOfWorkExperience,
      required this.hoursOfVolunteeringExperience,
      required this.languageTest,
      required this.languageLevelLetter,
      required this.funding,
      required this.requiredDegree,
      required this.nationalities});

      factory Scholarship.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'description': String description,
        'providedBy': String providedBy,
        'link': String link,
        'applyDate': String applyDate,
        'availabeSeats': int availabeSeats,
        'deadline': String deadline,
        'isArchived': bool isArchived,
        'minimumGPA': double minimumGPA,
        'location': String location,
        'fieldOfStudy': String fieldOfStudy,
        'languageTest': String languageTest,
        'languageLevelLetter': String languageLevelLetter,
        'funding': String funding,
         'hoursOfWorkExperience': int hoursOfWorkExperience,
        'hoursOfVolunteeringExperience': int hoursOfVolunteeringExperience,
        'requiredDegree': String requiredDegree,
        'nationalities':List <dynamic> nationalities,
             
      } =>
        Scholarship(
          title: title, 
          description:description,
          providedBy: providedBy,
          link:link,
          fieldOfStudy:fieldOfStudy,
          availabeSeats:availabeSeats,
          applyDate:applyDate,
          deadline:deadline,
          isArchived:isArchived,
          minimumGPA: minimumGPA,
          location:location,

          hoursOfWorkExperience: hoursOfWorkExperience,
          hoursOfVolunteeringExperience: hoursOfVolunteeringExperience,
          languageTest: languageTest,
          languageLevelLetter: languageLevelLetter,
          funding:funding,
          requiredDegree: requiredDegree,
          nationalities: nationalities,

        ),
      _ => throw const FormatException('Failed to load album.'),
    };
}
}
