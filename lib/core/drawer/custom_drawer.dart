import 'package:flutter/material.dart';
import 'package:murafik/core/util/constant.dart';
import 'drawer_item_model.dart';
import 'drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String role;
  final List<DrawerItemModel> items;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.role,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // 🔝 Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kPGradient),
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  role,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          // 🔽 Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ...items.map(
                    (item) => DrawerItem(
                      icon: item.icon,
                      title: item.title,
                      onTap: item.onTap,
                      trailing: item.trailing,
                      isDanger: item.isDanger,
                    ),
                  ),

                  const Spacer(),
                  const Divider(),

                  DrawerItem(
                    icon: Icons.logout,
                    title: "Logout",
                    onTap: () {},
                    isDanger: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
