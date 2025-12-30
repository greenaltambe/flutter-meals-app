import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }

  void _togglMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Meal removed from favorites.');
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage('Meal added to favorites.');
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _togglMealFavoriteStatus,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _togglMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: NavigationBar(
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        selectedIndex: _selectedPageIndex,
        onDestinationSelected: _selectPage,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border),
            selectedIcon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),

      /**
       * bottomNavigationBar: BottomNavigationBar(
  currentIndex: _selectedPageIndex,
  onTap: _selectPage,
  type: BottomNavigationBarType.fixed, // IMPORTANT
  selectedItemColor: Theme.of(context).colorScheme.primary,
  unselectedItemColor: Colors.grey,
  showUnselectedLabels: false, // modern look
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star),
      label: 'Favorites',
    ),
  ],
),

       */
    );
  }
}
