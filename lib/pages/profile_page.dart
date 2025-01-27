import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../utils/error_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProv;
  late final void Function() _removeListener;

  @override
  void initState() {
    super.initState();
    debugPrint('initState');
    profileProv = context.read<ProfileProvider>();
    _removeListener = profileProv.addListener(errorDialogListener);
    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<fbAuth.User?>()!.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener(ProfileState state) {
    if (state.profileStatus == ProfileStatus.error) {
      debugPrint('errorDialog');
      errorDialog(context, state.error);
    }
  }

  @override
  void dispose() {
    debugPrint('dispose');
    _removeListener();
    super.dispose();
  }

  Widget _buildProfile() {
    final profileState = context.watch<ProfileState>();

    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    } else if (profileState.profileStatus == ProfileStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (profileState.profileStatus == ProfileStatus.error) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.png',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20.0),
            const Text(
              'Ooops!\nTry again',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: profileState.user.profileImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- id: ${profileState.user.id}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '- name: ${profileState.user.name}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '- email: ${profileState.user.email}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '- point: ${profileState.user.point}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '- rank: ${profileState.user.rank}',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _buildProfile(),
    );
  }
}
