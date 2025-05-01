import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  timeDilation = 5;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop Animation',
      theme: ThemeData.light(), // Use light theme
      home: CoffeeListScreen(),
    );
  }
}

class CoffeeCategory {
  final String name;
  final String image;
  final String description;
  final List<String> drinks;

  CoffeeCategory({
    required this.name,
    required this.image,
    required this.description,
    required this.drinks,
  });
}

class CoffeeListScreen extends StatelessWidget {
  CoffeeListScreen({super.key});

  final List<CoffeeCategory> categories = [
    CoffeeCategory(
      name: 'Espresso',
      image: 'images/Espresso.png',
      description:
          'Strong and rich, espresso is the base for many coffee drinks and served in small concentrated shots.',
      drinks: ['Single Shot', 'Double Shot', 'Ristretto', 'Lungo'],
    ),
    CoffeeCategory(
      name: 'Latte',
      image: 'images/Latte.png',
      description:
          'Creamy and smooth, a latte is made with espresso and steamed milk, perfect for those who like it mellow.',
      drinks: ['Vanilla Latte', 'Caramel Latte', 'Hazelnut Latte', 'Iced Latte'],
    ),
    CoffeeCategory(
      name: 'Cold Brew',
      image: 'images/ColdBrew.png',
      description:
          'Brewed slowly in cold water for a smoother, less acidic taste. Best served chilled.',
      drinks: ['Original', 'Vanilla Sweet Cream', 'Cold Brew Tonic'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Shop'),
        backgroundColor: const Color(0xFFd0b8a8), // Light beige brown
      ),
      backgroundColor: const Color(0xFFFFF8F0), // Cream background
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final coffee = categories[index];
          return Card(
            color: const Color(0xFFFFF3E0), // Very light coffee
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Hero(
                tag: coffee.image,
                child: Image.asset(
                  coffee.image,
                  width: 60,
                  height: 60,
                ),
              ),
              title: Text(
                coffee.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.brown),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeeDetailScreen(category: coffee),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CoffeeDetailScreen extends StatelessWidget {
  final CoffeeCategory category;

  const CoffeeDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        backgroundColor: const Color(0xFFc8a98b), // Soft brown
      ),
      backgroundColor: const Color(0xFFFFFBF5), // Light cream
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: category.image,
            child: Image.asset(
              category.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              category.description,
              style: const TextStyle(fontSize: 18, color: Colors.brown),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Popular Drinks:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: category.drinks
                  .map((drink) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text('• $drink',
                            style: const TextStyle(fontSize: 16, color: Colors.black87)),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
