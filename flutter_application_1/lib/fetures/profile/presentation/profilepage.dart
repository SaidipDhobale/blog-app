import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';

import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application_1/fetures/profile/presentation/edit_profile_Page.dart';
import 'package:flutter_application_1/fetures/profile/presentation/profile_image_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    if (context.read<UserCubit>().state is UserLoggedIn) {
      final id = (context.read<UserCubit>().state as UserLoggedIn).user.id;
      context.read<ProfileBloc>().add(GetProfileDataEvent(id: id));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final local=AppLocalizations.of(context)!;
    return Scaffold(
      // bottomNavigationBar: const MyBottomNavBar(
      //   currentIndex: 1,
      // ),
      appBar: AppBar(
        backgroundColor: AppPallete.gradient2,
        title: Text(local.profile),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is GetProfileStatefailure) {
            log(state.message);
          }
        },
        builder: (context, state) {
          if (state is GetProfileState) {
            return SafeArea(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                children: [
                  // Profile Picture
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>FullScreenImagePage(profileImage:state.profile.profileImage)));
                    },
                    child: Center(
                        child: Container(
                      padding: const EdgeInsets.all(
                          2), // space between border and avatar
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppPallete.gradient1, // 🔵 border color
                          width: 3, // border thickness
                        ),
                      ),
                    
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(255, 166, 202, 231),
                        backgroundImage: state.profile.profileImage.isNotEmpty
                            ? NetworkImage(state.profile.profileImage)
                            : null,
                        child: state.profile.profileImage.isEmpty
                            ? Icon(
                                Iconsax.profile_circle,
                                size: 50,
                                color: Colors.grey[600],
                              )
                            : null,
                      ),
                    )),
                  ),
                  const SizedBox(height: 24),

                  // Full Name
                  ListTile(
                    leading: const Icon(Iconsax.user),
                    title:  Text(local.fullName),
                    subtitle: Text(state.profile.name),
                  ),
                  const Divider(),

                  // Email
                  ListTile(
                    leading: const Icon(Iconsax.sms),
                    title:  Text(local.email),
                    subtitle: Text(state.profile.email),
                  ),
                  const Divider(),

                  // Phone
                  ListTile(
                    leading: const Icon(Iconsax.call),
                    title:  Text(local.phone),
                    subtitle: Text(state.profile.mobileNo.toString()),
                  ),
                  const Divider(),

                  // Edit Profile Button
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Iconsax.edit),
                    label:Text(local.editProfile),
                    onPressed: () {
                      Profile profile = state.profile;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditProfilePage(
                                  name: profile.name,
                                  email: profile.email,
                                  mobile: profile.mobileNo,
                                  profileImageUrl: profile.profileImage)));
                      // Navigate to Edit Profile screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.gradient1,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Logout Button
                  OutlinedButton.icon(
                    icon: const Icon(Iconsax.logout),
                    label:  Text(local.logout),
                    onPressed: () {
                      // Perform logout logic
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
