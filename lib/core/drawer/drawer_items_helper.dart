import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'drawer_item_model.dart';
import 'user_role.dart';

List<DrawerItemModel> getDrawerItems(BuildContext context, UserRole role) {
  switch (role) {
    // 👨‍💼 Supervisor
    case UserRole.supervisor:
      return [
        DrawerItemModel(
          icon: Icons.dashboard,
          title: "Supervisor Home",
          onTap: () => context.push('/supervisor/home'),
        ),
        DrawerItemModel(
          icon: Icons.person,
          title: "Patient",
          onTap: () => context.push('/patient/details'),
        ),
        DrawerItemModel(
          icon: Icons.notifications,
          title: "Alerts",
          onTap: () => context.push('/patient/alerts'),
        ),
      ];

    // 👨‍⚕️ Doctor
    case UserRole.doctor:
      return [
        DrawerItemModel(
          icon: Icons.people,
          title: "All Patients",
          onTap: () => context.push('/doctor/patients'),
        ),
        DrawerItemModel(
          icon: Icons.warning_amber_rounded,
          title: "Critical Cases",
          onTap: () => context.push('/doctor/critical'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "3",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
        DrawerItemModel(
          icon: Icons.notifications,
          title: "All Alerts",
          onTap: () => context.push('/doctor/alerts'),
        ),
      ];
  }
}
