import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/features/portfolio/viewmodels/portfolio_controller.dart';
import 'package:my_portfolio/main.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('Desktop renders all sections and TopNav scrolls to Contact', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Shahria Sayad'), findsWidgets);
    expect(find.text('View CV'), findsOneWidget);
    expect(find.text('Get in Touch'), findsOneWidget);
    expect(find.text('Explore Projects'), findsOneWidget);
    expect(find.text('Softvence Agency'), findsOneWidget);
    expect(find.text('Taco Client'), findsOneWidget);
    expect(find.text('Taco Conductor'), findsOneWidget);
    expect(find.text('Florida Yacht Trader'), findsOneWidget);
    expect(find.text('Jupiter Marine Sales'), findsOneWidget);
    expect(find.text('4 SHIPPED PRODUCTS'), findsOneWidget);
    expect(find.text('APP 04'), findsOneWidget);
    expect(find.text('Agora Connect'), findsWidgets);
    expect(find.text('Meal Khata'), findsWidgets);
    expect(find.text('BdCalling Academy'), findsOneWidget);
    expect(find.textContaining('Uttara University (UU)'), findsOneWidget);
    expect(find.text('Send Message'), findsOneWidget);

    final ctrl = Get.find<PortfolioController>();
    expect(ctrl.liveApps.length, 4);
    expect(ctrl.heroStats.first.value, '4');
    expect(ctrl.scrollController.offset, 0.0);

    // Tap TopNav "Contact" link and verify scroll jumps down
    await tester.tap(find.text('Contact').first);
    await tester.pumpAndSettle();
    expect(ctrl.scrollController.offset, greaterThan(500.0));

    // Validate contact form inline
    await tester.ensureVisible(find.text('Send Message'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Send Message'));
    await tester.pumpAndSettle();
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Message is required'), findsOneWidget);

    // Tap brand mark to return to top
    await tester.tap(find.text('S/'));
    await tester.pumpAndSettle();
    expect(ctrl.scrollController.offset, lessThan(100.0));
  });

  testWidgets('Tablet viewport renders cleanly with mobile drawer menu', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pumpAndSettle();

    expect(find.text('NAVIGATE'), findsOneWidget);
    await tester.tap(find.text('Projects').last);
    await tester.pumpAndSettle();

    final ctrl = Get.find<PortfolioController>();
    expect(ctrl.scrollController.offset, greaterThan(200.0));
  });

  testWidgets('Narrow mobile viewport renders without overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 740);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
    expect(find.text('Shahria Sayad'), findsWidgets);
    expect(find.text('Florida Yacht Trader'), findsOneWidget);
    expect(find.text('Jupiter Marine Sales'), findsOneWidget);
  });
}
