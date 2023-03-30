import 'package:flutter/material.dart';
import 'package:instagram/ui/profile/profile_view.dart';
import 'package:instagram/ui/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProfileViewModel>(
            create: (_) => ProfileViewModel())
      ],
      child: const ProfileView(),
    );
  }
}
