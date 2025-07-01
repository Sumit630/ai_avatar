class UserModel {
  final String title;
  final String firstName;
  final String lastName;
  final String fullName;
  final String gender;
  final String email;
  final String username;
  final String phone;
  final String cell;
  final int age;
  final String dob;
  final String country;
  final String city;
  final String state;
  final String streetName;
  final int streetNumber;
  final String imageLarge;
  final String imageMedium;
  final String imageThumb;
  final String nationality;

  UserModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.gender,
    required this.email,
    required this.username,
    required this.phone,
    required this.cell,
    required this.age,
    required this.dob,
    required this.country,
    required this.city,
    required this.state,
    required this.streetName,
    required this.streetNumber,
    required this.imageLarge,
    required this.imageMedium,
    required this.imageThumb,
    required this.nationality,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? {};
    final location = json['location'] ?? {};
    final street = location['street'] ?? {};
    final picture = json['picture'] ?? {};
    final dob = json['dob'] ?? {};
    final login = json['login'] ?? {};

    return UserModel(
      title: name['title']?.toString() ?? '',
      firstName: name['first']?.toString() ?? '',
      lastName: name['last']?.toString() ?? '',
      fullName: '${name['first']?.toString() ?? ''} ${name['last']?.toString() ?? ''}',
      gender: json['gender']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      username: login['username']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      cell: json['cell']?.toString() ?? '',
      age: dob['age'] is int ? dob['age'] : int.tryParse(dob['age']?.toString() ?? '') ?? 0,
      dob: dob['date']?.toString() ?? '',
      country: location['country']?.toString() ?? '',
      city: location['city']?.toString() ?? '',
      state: location['state']?.toString() ?? '',
      streetName: street['name']?.toString() ?? '',
      streetNumber: street['number'] is int
          ? street['number']
          : int.tryParse(street['number']?.toString() ?? '') ?? 0,
      imageLarge: picture['large']?.toString() ?? '',
      imageMedium: picture['medium']?.toString() ?? '',
      imageThumb: picture['thumbnail']?.toString() ?? '',
      nationality: json['nat']?.toString() ?? '',
    );
  }
}
