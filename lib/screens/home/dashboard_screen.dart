import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// --- Import your screens ---
import 'drawer_menu.dart';
import '../appointment_screen.dart';
import '../profile_screen.dart';
import '../policyscreen.dart'; 
import 'package:aapka_sathi/screens/vendor_support_screen.dart';
import 'package:aapka_sathi/screens/digital_access.dart';
import 'package:aapka_sathi/screens/financial_aid_screen.dart';
import 'package:aapka_sathi/screens/training_screen.dart';
import 'package:aapka_sathi/screens/support_desk_screen.dart';
import 'package:aapka_sathi/screens/legal_screen.dart';
import 'package:aapka_sathi/screens/door_to_door_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;

  final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
  }

  Future<void> _onItemTapped(int index) async {
    // FIX: Close keyboard if open when switching tabs
    FocusScope.of(context).unfocus();

    if (_isDrawerOpen) _closeDrawer();

    // Handle YouTube Link (Index 2)
    if (index == 2) {
      final Uri url = Uri.parse("https://youtube.com/@aapkasathi09?si=qGcLu1m6pLNn-odx");
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Could not open YouTube link")));
        }
      }
      return; 
    }

    // Normal Tab Switching
    if (_selectedIndex == index && index == 0) {
      // If tapping Home while already on Home, go to the very start (Grid)
      _homeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double drawerWidth = (size.width * 0.50).clamp(200.0, 300.0);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        // Close keyboard first if open when back button is pressed
        if (FocusScope.of(context).hasFocus) {
           FocusScope.of(context).unfocus();
           return;
        }

        if (_isDrawerOpen) {
          _closeDrawer();
          return;
        }

        // If on Home Tab, try to go back inside the nested navigator
        if (_selectedIndex == 0) {
          final isFirstRouteInCurrentTab = !await _homeNavigatorKey.currentState!.maybePop();
          if (!isFirstRouteInCurrentTab) {
            return;
          }
        }

        if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        
        body: Stack(
          children: [
            // LAYER A: Main Content Area
            GestureDetector(
              // Close keyboard when tapping anywhere outside
              onTap: () {
                if (_isDrawerOpen) _closeDrawer();
                FocusScope.of(context).unfocus();
              },
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  // TAB 0: HOME (With Nested Navigator)
                  Navigator(
                    key: _homeNavigatorKey,
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (_) => HomeContent(
                          onMenuTap: _toggleDrawer, 
                          // Pass navigation helper
                          onNavigate: (Widget page) {
                            // Ensure keyboard is closed before navigating
                            FocusScope.of(context).unfocus();
                            _homeNavigatorKey.currentState!.push(
                              MaterialPageRoute(builder: (_) => page)
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const AppointmentScreen(),
                  const SizedBox(), 
                  const ProfileScreen(),
                ],
              ),
            ),

            // LAYER B: Scrim (Dark overlay)
            if (_isDrawerOpen)
              GestureDetector(
                onTap: () {
                  _closeDrawer();
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

            // LAYER C: Drawer Menu
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _isDrawerOpen ? 0 : -drawerWidth,
              top:10, bottom: 0,
              width: drawerWidth,
              child: DrawerMenu(
                userName: "User Name", 
                businessType: "Business Type",
                onClose: _closeDrawer,
                onOpen: () => setState(() => _isDrawerOpen = true),
              ),
            ),
          ],
        ),

        // BOTTOM NAV BAR
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color:   Color(0xFFFFD54F),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: NavigationBarTheme(
            data: const NavigationBarThemeData(indicatorColor: Colors.transparent),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor:  const Color(0xFF1A237E), // Using voilet color from theme.dart
              unselectedItemColor: Colors.black54,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped, 
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Appointment"),
                BottomNavigationBarItem(icon: Icon(Icons.school), label: "Training"), 
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- HOME CONTENT WIDGET ---
class HomeContent extends StatelessWidget {
  final VoidCallback onMenuTap;
  final Function(Widget) onNavigate; // Helper to push pages

  const HomeContent({super.key, required this.onMenuTap, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // We add SafeArea here because we removed the AppBar from the Scaffold
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildCustomAppBar(), // The Logo header is now here
      // FIX: GestureDetector ensures tapping empty space inside home content closes keyboard
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFF9C4),
                        ),
                        child: const TextField(
                          textInputAction: TextInputAction.search, 
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search, color: Colors.orange),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 45, width: 45,
                    decoration: BoxDecoration(color: const Color(0xFFFFF9C4), borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.notifications_none, color: Colors.black),
                  ),
                ],
              ),
              
              SizedBox(height: size.height * 0.02),
              
              // Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/banner2.png', width: double.infinity, fit: BoxFit.fitWidth,
                  errorBuilder: (ctx, err, stack) => Container(height: 150, color: Colors.grey[300], child: const Center(child: Text("Banner Image"))),
                ),
              ),

              SizedBox(height: size.height * 0.03),
              const Text("Our Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF424242))),
              SizedBox(height: size.height * 0.02),

              // Services Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                childAspectRatio: 0.75,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                children: [
                  _buildServiceItem("Policies", "assets/images/policy-icon.png", onTap: () => onNavigate(const PolicyScreen())),
                  _buildServiceItem("Vendor Support", "assets/images/vendor-icon.png", onTap: () => onNavigate(const VendorSupportScreen())),
                  _buildServiceItem("Digital Access", "assets/images/digital-icon.png", onTap: () => onNavigate(const DigitalAccessScreen())),
                  _buildServiceItem("Financial Aid", "assets/images/finance-icon.png", onTap: () => onNavigate(const FinancialAidScreen())),
                  _buildServiceItem("Training", "assets/images/skill-icon.png", onTap: () => onNavigate(const TrainingScreen())),
                  _buildServiceItem("Support Desk", "assets/images/support-icon.png", onTap: () => onNavigate(const SupportDeskScreen())),
                  _buildServiceItem("Legal", "assets/images/legal-icon.png", onTap: () => onNavigate(const LegalScreen())),
                  _buildServiceItem("Door to Door", "assets/images/door_icon.png", onTap: () => onNavigate(const DoorToScreen())),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              // Doctors & Advocates
              Row(
                children: [
                  Expanded(
                    child: _buildBigCategoryBox(
                      title: "Doctors", 
                      imagePath: "assets/images/doctor_icon.png", 
                      fallbackIcon: Icons.medical_services,
                      onTap: () => onNavigate(const AppointmentScreen()),
                    )
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildBigCategoryBox(
                      title: "Advocate", 
                      imagePath: "assets/images/advocate_icon.png", 
                      fallbackIcon: Icons.gavel,
                      onTap: () => onNavigate(const AppointmentScreen()),
                    )
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

   AppBar _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black, size: 30),
        onPressed: () {
          // Close keyboard before opening menu
          FocusManager.instance.primaryFocus?.unfocus();
          onMenuTap();
        },
      ),
      centerTitle: false,    
      titleSpacing: 0,    
      title: Container(
        padding: const EdgeInsets.only(left: 5), 
        child: Image.asset(
          'assets/images/logo.png', height: 40, fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Text("APP LOGO", style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Location", style: TextStyle(fontSize: 10, color: Colors.black)),
              Row(
                children: const [
                  Icon(Icons.location_on, size: 14, color: Colors.black),
                  Text(" Gwalior, India", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildServiceItem(String label, String imagePath, {VoidCallback? onTap, IconData fallbackIcon = Icons.grid_view}) {
    return GestureDetector(
      onTap: onTap, 
      child: Column(
        children: [
          Container(
            height: 60, width: 60,
            decoration: const BoxDecoration(color: Color(0xFFFFF9C4), shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(imagePath, errorBuilder: (c, e, s) => Icon(fallbackIcon, color: const Color(0xFFFBC02D), size: 30)),
            ),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildBigCategoryBox({
    required String title, 
    required String imagePath, 
    required IconData fallbackIcon,
    VoidCallback? onTap, 
  }) {
    return GestureDetector(
      onTap: onTap, 
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFFFFF9C4), borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.7, heightFactor: 0.7,
                  child: Image.asset(imagePath, fit: BoxFit.contain, errorBuilder: (c, e, s) => Icon(fallbackIcon, size: 80, color: const Color(0xFFFBC02D))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}