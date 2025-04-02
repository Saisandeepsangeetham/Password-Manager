import 'dart:convert';
import 'package:http/http.dart' as http;

class PasswordModel {
  int? id;
  String domain;
  String username;
  String password;
  String? iconUrl;

  PasswordModel(
      {this.id,
      required this.domain,
      required this.username,
      required this.password,
      this.iconUrl});

  static Future<PasswordModel> create({
    int? id,
    required String domain,
    required String username,
    required String password,
  }) async {
    final iconUrl = await fetchIconUrl(domain);
    return PasswordModel(
      id: id,
      domain: domain,
      username: username,
      password: password,
      iconUrl: iconUrl,
    );
  }

  static Future<String> fetchIconUrl(String domain) async {
    try {
      final url = 'https://icons.duckduckgo.com/ip3/$domain.to.ico';
      //https://icon.horse/icon/dev.to
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return url;
      } else {
        return 'https://via.placeholder.com/48';
      }
    } catch (e) {
      return 'https://via.placeholder.com/48';
    }
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      id: map['id'],
      domain: map['domain'],
      username: map['username'],
      password: map['password'],
      iconUrl: map['iconUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'domain': domain,
      'username': username,
      'password': password,
      'iconUrl': iconUrl,
    };
  }
}
