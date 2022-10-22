class Users {
  final String nik;
  final String namaLengkap;
  final String email;
  final String phone;

  Users._({
    required this.nik,
    required this.namaLengkap,
    required this.email,
    required this.phone,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users._(
      nik: json['nik'],
      email: json['email'],
      namaLengkap: json['nama_lengkap'],
      phone: json['phone'],
    );
  }
}
