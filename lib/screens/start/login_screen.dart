import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State variable to toggle password visibility
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD54F),
      resizeToAvoidBottomInset: true, 

      body: SafeArea(
        top: false, 
        child: Column(
          children: [
            // --- TOP SECTION (35% of screen height) ---
            Expanded(
              flex: 40, // 40% of the vertical space
              child: Container(
                width: double.infinity,
                color: const Color(0xFFFFF5D2),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/login_bg.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.person, size: 80, color: Colors.black),
                          );
                        },
                      ),
                    ),
                    
                    Positioned(
                      left: 20, 
                      bottom: 10, // Slight padding from bottom
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: 36, // Slightly reduced for better fit
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF3E2723),
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "Welcome to Aapka Sathi",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF5D4037),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SafeArea(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0), 
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.black, size: 28),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- BOTTOM SECTION: Login Form (60% of screen height) ---
            Expanded(
              flex: 60, // 60% of the vertical space
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 30.0), 
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD54F),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Use Spacer to distribute space evenly instead of fixed heights
                    const Spacer(flex: 1), 
                    
                    const HoverText(
                      text: "Login",
                      baseStyle: TextStyle(
                        fontSize: 30, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const Spacer(flex: 1),

                    // Input Fields Group
                    _buildCustomTextField(
                      hint: "Mobile Number / Email",
                    ),
                    
                    const SizedBox(height: 12), 
                    
                    _buildCustomTextField(
                      hint: "Password",
                      isPassword: true,
                      obscureText: _isPasswordObscured,
                      onToggleVisibility: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 30), 
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ), 
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Color(0xFF3E2723),
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    const Spacer(flex: 1),

                    SizedBox(
                      width: double.infinity,
                      height: 50, 
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/dashboard', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBC02D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3, 
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const Spacer(flex: 1),
                    
                    const Divider(
                      color: Color(0xFF3E2723),
                      thickness: 1,
                      indent: 50, 
                      endIndent: 50,
                    ),
                    
                  

                    const HoverText(
                      text: "If not registered?",
                      baseStyle: TextStyle(color: Color(0xFF3E2723), fontSize: 14),
                    ),
                    
                    HoverText(
                      text: "Click Here",
                      onTap: () =>
                          Navigator.pushNamed(context, '/register_personal'),
                      baseStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                    
                    const Spacer(flex: 3), // Bottom padding buffer
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword ? obscureText : false,
        style: const TextStyle(color: Colors.black, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54, fontSize: 15),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          isDense: true, 
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Tighter padding
          suffixIcon: isPassword
              ? IconButton(
                  iconSize: 20, // Smaller icon
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}

// --- HoverText Class ---
class HoverText extends StatefulWidget {
  final String text;
  final TextStyle baseStyle;
  final VoidCallback? onTap;

  const HoverText({
    super.key,
    required this.text,
    required this.baseStyle,
    this.onTap,
  });

  @override
  State<HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = _isHovered || _isPressed;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isActive
                ? const Color.fromARGB(255, 6, 13, 139)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.text,
            style: widget.baseStyle.copyWith(
              color: isActive ? Colors.white : widget.baseStyle.color,
            ),
          ),
        ),
      ),
    );
  }
}