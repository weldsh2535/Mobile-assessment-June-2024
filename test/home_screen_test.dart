import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:flutter_assessment/screens/home_screen.dart';
import 'package:flutter_assessment/widgets/product_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Mock the HTTP client
class MockClient extends Mock implements http.Client {}

void main() {
  group('HomeScreen', () {
    testWidgets('displays products after fetching from API', (WidgetTester tester) async {
      // Arrange
      final mockClient = MockClient();
      final cart = Cart();

      final productsJson = [
        {
          "id": 1,
          "title": "Product 1",
          "price": 10.0,
          "description": "Description of Product 1",
          "category": "Category 1",
          "image": "https://example.com/image1.png",
          "rating": {"rate": 4.5, "count": 10}
        },
        // Add more products as needed
      ];

      when(mockClient.get(Uri.parse('https://fakestoreapi.com/products')))
          .thenAnswer((_) async => http.Response(json.encode(productsJson), 200));

      // Act
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => cart,
          child: MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      // Trigger the API call
      await tester.pump();

      // Assert
      expect(find.text('Products'), findsOneWidget);
      expect(find.byType(ProductItem), findsNWidgets(productsJson.length));
      expect(find.text('Product 1'), findsOneWidget);
    });

    testWidgets('displays loading indicator while fetching products', (WidgetTester tester) async {
      // Arrange
      final mockClient = MockClient();
      final cart = Cart();

      when(mockClient.get(Uri.parse('https://fakestoreapi.com/products')))
          .thenAnswer((_) async {
        return Future.delayed(const Duration(seconds: 2), () {
          return http.Response('[]', 200);
        });
      });

      // Act
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => cart,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete the future
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
