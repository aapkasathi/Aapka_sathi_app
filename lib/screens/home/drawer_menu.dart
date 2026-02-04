import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatelessWidget {
  // Data fields
  final String userName;
  final String businessType;
  final ImageProvider? profilePhoto;

  final VoidCallback onClose;
  final VoidCallback onOpen;

  const DrawerMenu({
    super.key,
    this.userName = "User Name",
    this.businessType = "Business Type",
    this.profilePhoto,
    required this.onClose,
    required this.onOpen,
  });

  
  Future<void> _launchYoutubeChannel() async {
    final Uri url = Uri.parse('https://youtube.com/@aapkasathi09?si=qGcLu1m6pLNn-odx');
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Calculate exactly 40% of the screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double drawerWidth = screenWidth * 0.40;
    final double horizontalPadding = 15.0;

    // 2. Use SizedBox to force the specific width constraints on the Drawer
    return SizedBox(
      width: drawerWidth,
      child: Material(
        color: Colors.white, 
        // Elevation/Shadow to separate drawer from app content
        elevation: 10.0, 
        shape: const Border(
          right: BorderSide(color: Colors.black12, width: 1),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    left: horizontalPadding, 
                    right: horizontalPadding, 
                    top: 20, 
                    bottom: 10
                  ),
                  children: [
                    // ----------------------------------------
                    // 1. PROFILE SECTION
                    // ----------------------------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFC107), // Yellow Border
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 40, // Adjusted radius to fit 40% width better if screen is small
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: profilePhoto ??
                                const AssetImage('assets/images/profile_placeholder.png'),
                            child: profilePhoto == null
                                ? const Icon(Icons.person, size: 40, color: Colors.grey)
                                : null,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18, // Slightly reduced font to fit 40% width
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          businessType,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9E9E9E), // Light Grey
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    const Divider(color: Color(0xFFFFC107), thickness: 1.5),
                    const SizedBox(height: 20),

                    // ----------------------------------------
                    // 2. LICENSES & CERTIFICATES
                    // ----------------------------------------
                    _buildSectionHeader("Licenses & Certtificates"), // Shortened title for narrow width
                    _buildMenuItem(context, "Licenses", Icons.card_membership, '/licenses'),
                    _buildMenuItem(context, "Certificates", Icons.workspace_premium_outlined, '/certificates'),

                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 10),

                    // ----------------------------------------
                    // 3. INFORMATION SECTION
                    // ----------------------------------------
                    _buildSectionHeader("Information"),
                    _buildMenuItem(context, "Policies", Icons.policy_outlined, '/policies'),
                    _buildMenuItem(context, "Licenses Info", Icons.info_outline, '/licenses_info'),

                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFEEEEEE), thickness: 1),
                    const SizedBox(height: 10),

                    // ----------------------------------------
                    // 4. OTHERS
                    // ----------------------------------------
                    _buildSectionHeader("Others"),

                    _buildMenuItem(context, "Renewal Form", Icons.autorenew, '/renewal_form'),
                    _buildMenuItem(context, "Payment Receipt", Icons.receipt_long_outlined, '/payment_receipt'),

                    // Training (YouTube Link)
                    InkWell(
                      onTap: () {
                        onClose();
                        _launchYoutubeChannel();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.school_outlined, size: 20, color: Color(0xFF757575)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Training",
                                style: TextStyle(
                                  fontSize: 13, // Adjusted for space
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    _buildMenuItem(context, "Help & Support", Icons.help_outline, '/help'),
                    _buildMenuItem(context, "Setting", Icons.settings_outlined, '/settings'),

                    const SizedBox(height: 10),

                    // Logout
                    InkWell(
                      onTap: () {
                        onClose();
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.logout, size: 20, color: Colors.redAccent),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14, // Slightly smaller header for 40% width
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, String routeName) {
    return InkWell(
      onTap: () async {
        onClose(); // Close drawer
        try {
          final result = await Navigator.pushNamed(context, routeName);
          if (result == true) {
            onOpen();
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("Page $title not created yet!"))
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF757575),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13, 
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}