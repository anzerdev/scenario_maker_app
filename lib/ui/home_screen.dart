import 'package:flutter/material.dart';
import 'package:scenario_maker_app/ui/screens/saved_scenarios/saved_scenarios_screen.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/platform_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const PlatformSelectionScreen(),
    const SavedScenariosScreen(),
  ];
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        _selectedIndex, 
        duration: const Duration(milliseconds: 200), 
        curve: Curves.easeInOut,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // чтобы не мотал экран
        children: _screens, // список экранов, которые будут проматывать
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
           items: <BottomNavigationBarItem>[
              _buildBottomNavigationBarItem(Icons.home, 'Home', 0),
              _buildBottomNavigationBarItem(Icons.bookmark, 'Saved', 1),
            ], 
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue[600],
            unselectedItemColor: Colors.grey[400],
            iconSize: 28,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped, 
          ), 
        )          
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(IconData icon, String label, int index) {
    bool isSelected = index == _selectedIndex;

    return BottomNavigationBarItem(icon: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(begin: 1.0, end: isSelected ? 1.2 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Icon(
              icon,
              color: isSelected ? Colors.blue[600] : Colors.grey[400],
            ),
          );
        },
      ),
      label: label,
    );
  }
}