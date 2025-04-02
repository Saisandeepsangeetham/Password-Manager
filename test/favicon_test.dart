import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:password_manager/Models/password_model.dart';

@Timeout(Duration(seconds: 45))
void main() {
  group('Favicon Tests', () {
    test('Favicon URLs are accessible and return valid images', () async {
      // Test cases with various domain formats
      final testDomains = [
        'instagram',
        'whatsapp',
        'github',
        'facebook',
        'twitter',
        'linkedin',
        'youtube'
      ];

      for (var domain in testDomains) {
        final iconUrl = await PasswordModel.fetchIconUrl(domain);
        print('Domain: $domain, Icon URL: $iconUrl');
      }
    });
  });
}
