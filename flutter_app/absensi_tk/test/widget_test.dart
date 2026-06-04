import 'package:flutter_test/flutter_test.dart';
import 'package:absensi_tk/main.dart';
import 'package:absensi_tk/routes/app_routes.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // Bangun aplikasi dengan memberikan initialRoute (Login) sebagai parameter wajib
    await tester.pumpWidget(const MyApp(
      initialRoute: AppRoutes.login,
    ));

    // Memastikan aplikasi berhasil dimuat dengan mengecek keberadaan widget MyApp
    expect(find.byType(MyApp), findsOneWidget);
  });
}
