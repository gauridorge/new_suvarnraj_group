import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:new_suvarnraj_group/controller/user_controller.dart';
import 'package:new_suvarnraj_group/pages/aboutus_page.dart';
import 'package:new_suvarnraj_group/pages/login.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userCtrl = Get.find<UserController>();

    return Obx(() => Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: userCtrl.isLoggedIn.value
          ? _buildProfile(context, userCtrl)
          : _buildGuestView(context),
    ));
  }

  /// Logged-in profile UI
  Widget _buildProfile(BuildContext context, UserController userCtrl) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              /// Profile Header
              CircleAvatar(
                radius: isTablet ? 40 : 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person,
                    size: isTablet ? 45 : 55, color: Colors.white),
              ),
              SizedBox(height: 1.5.h),
              Text(userCtrl.name.value,
                  style: TextStyle(
                      fontSize: isTablet ? 16.sp : 18.sp,
                      fontWeight: FontWeight.bold)),
              Text(userCtrl.email.value,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey)),

              SizedBox(height: 2.h),

              /// Contact Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact Information",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                    SizedBox(height: 1.h),
                    _contactItem(Icons.phone, userCtrl.phone.value),
                    _contactItem(Icons.location_on,
                        "123 Main Street, Mumbai, 400001"),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              /// Menu Items – Responsive Grid
              _menuGrid([
                _ProfileMenuItem(
                    icon: FontAwesomeIcons.userPen,
                    text: "Edit Profile",
                    bgColor: Colors.blue),
                _ProfileMenuItem(
                    icon: FontAwesomeIcons.bookOpen,
                    text: "My Bookings",
                    bgColor: Colors.green),
                _ProfileMenuItem(
                    icon: FontAwesomeIcons.heart,
                    text: "Favorites",
                    bgColor: Colors.pink),
                _ProfileMenuItem(
                    icon: FontAwesomeIcons.bell,
                    text: "Notifications",
                    bgColor: Colors.orange),
                _ProfileMenuItem(
                    icon: FontAwesomeIcons.headset,
                    text: "Support",
                    bgColor: Colors.purple),
                _ProfileMenuItem(
                  icon: FontAwesomeIcons.circleInfo,
                  text: "About Us",
                  bgColor: Colors.indigo,
                  onTap: () => Get.to(() => const AboutUsPage()),
                ),
              ]),

              SizedBox(height: 2.h),

              /// Logout Section
              _menuGrid([
                _ProfileMenuItem(
                  icon: FontAwesomeIcons.arrowRightFromBracket,
                  text: "Logout",
                  bgColor: Colors.red,
                  color: Colors.red,
                  onTap: () {
                    userCtrl.logout();
                    Get.snackbar("Logout", "You have been logged out",
                        snackPosition: SnackPosition.BOTTOM);
                  },
                ),
              ]),

              SizedBox(height: 3.h),
              Text("Version 1.0.0",
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Guest view if not logged in
  Widget _buildGuestView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_outline, size: 80, color: Colors.grey),
          SizedBox(height: 2.h),
          Text("You are not logged in",
              style: TextStyle(fontSize: 14.sp, color: Colors.black54)),
          SizedBox(height: 2.h),
          ElevatedButton(
            onPressed: () => Get.to(() => const LoginPage()),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.w))),
            child: Text("Login",
                style: TextStyle(fontSize: 13.sp, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Contact item widget
  Widget _contactItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, color: Colors.blue, size: 16),
          ),
          SizedBox(width: 3.w),
          Expanded(
              child:
              Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.black87))),
        ],
      ),
    );
  }

  /// Responsive Grid
  Widget _menuGrid(List<_ProfileMenuItem> items) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = 1;
      if (constraints.maxWidth > 900) {
        crossAxisCount = 3; // Desktop
      } else if (constraints.maxWidth > 600) {
        crossAxisCount = 2; // Tablet
      }
      return GridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 4,
        children: items,
      );
    });
  }
}

/// Menu Item Widget
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color bgColor;
  final VoidCallback? onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.text,
    this.color = Colors.black,
    this.bgColor = Colors.blue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: bgColor.withOpacity(0.15),
              child: Icon(icon, color: bgColor, size: 18),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: color,
                      fontWeight: FontWeight.w500)),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
