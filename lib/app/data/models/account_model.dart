class Account {
  final String name;
  final String username;
  final String password;
  final String phoneNumber;
  final String pin;
  final double saldo;
  final String uID;

  Account({
    required this.name,
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.pin,
    required this.saldo,
    required this.uID,
  });

  factory Account.fromMap(String key, Map<String, dynamic> map) {
    return Account(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phone_number'] ?? '',
      pin: map['pin'] ?? '',
      saldo: (map['saldo'] ?? 0.0).toDouble(),
      uID: map['uID'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'phone_number': phoneNumber,
      'pin': pin,
      'saldo': saldo,
      'uID': uID,
    };
  }
}
