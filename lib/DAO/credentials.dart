class Credentials {
  final String username;
  final String password;
  final String accountNumber;
  final int balance;

  Credentials(this.username, this.password, this.accountNumber, this.balance);

  Credentials.fromJson(Map<dynamic, dynamic> json)
      : username = json['username'] as String,
        password = json['password'] as String,
        accountNumber = json['accountNumber'] as String,
        balance = json['balance'] as int;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'email': username,
        'password': password,
        'accountNumber': accountNumber,
        'balance': balance,
      };
}
