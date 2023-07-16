import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moury/modules/features/congfig/view_model/config_view_model.dart';
import 'package:moury/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';
import 'core/app/app_routes.dart';
import 'core/services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  enableFirestorePersistence();
  await Firebase.initializeApp();
  await LocalStorageService.init();
  runApp(const Moury());
}

class Moury extends StatelessWidget {
  const Moury({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConfigViewModel());
    return OKToast(
      position: ToastPosition.bottom,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.routes,
        initialRoute: "/splash",
        theme: AppThemes.light,
      ),
    );
  }
}

void enableFirestorePersistence() async {
  try {
    await FirebaseFirestore.instance.enablePersistence();
  } catch (e) {
    print(e);
  }
}
