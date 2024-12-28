import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vou_games/core/widgets/dialogues/confirm_dialogue.dart';
import 'package:vou_games/features/user/domain/entities/user_profile_entity.dart';
import 'package:vou_games/features/user/presentation/bloc/user_bloc.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUserProfileEvent());
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          message: 'Are you sure you want to log out?',
          onConfirm: () {
            BlocProvider.of<AuthBloc>(context).add(AuthLoggedOutEvent());
            Navigator.of(context).pop();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showEditProfileDialog(BuildContext context, UserProfileEntity userProfile) {
    final TextEditingController emailController = TextEditingController(text: userProfile.email);
    final TextEditingController phoneController = TextEditingController(text: userProfile.phoneNumber);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            XFile? _imageFile;

            Future<void> _pickImage() async {
              final ImagePicker _picker = ImagePicker();
              final XFile? selected = await _picker.pickImage(source: ImageSource.gallery);
              setState(() {
                _imageFile = selected;
              });
            }

            return AlertDialog(
              title: const Text('Edit Profile'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
                      child: _imageFile == null ? const Icon(Icons.person) : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle save action
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Homepage'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoadedState) {
            final userProfile = state.userProfile;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // User Profile Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: Text(userProfile.userName[0]),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userProfile.userName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email),
                            const SizedBox(width: 8),
                            Text(userProfile.email),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone),
                            const SizedBox(width: 8),
                            Text(userProfile.phoneNumber),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => _showEditProfileDialog(context, userProfile),
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  // Actions Section
                  ListTile(
                    leading: const Icon(Icons.add_chart_rounded),
                    title: const Text('Puzzle Collection'),
                    onTap: () {
                      // Navigate to Puzzle Collection
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite),
                    title: const Text('Favorite Campaigns'),
                    onTap: () {
                      // Navigate to Favorite Campaigns
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.support),
                    title: const Text('Support'),
                    onTap: () {
                      // Navigate to Support
                    },
                  ),
                  const Divider(),
                  // Logout Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () => _showLogoutDialog(context),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Log out'),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserProfileErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No user profile available.'));
        },
      ),
    );
  }
}