import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/core/theme/app_palate.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/core/utils/image_picker.dart';
import 'package:flutter_application_1/core/utils/imaged.dart';
import 'package:flutter_application_1/fetures/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_application_1/fetures/profile/presentation/profilepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final int mobile;
  final String profileImageUrl;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.mobile,
    required this.profileImageUrl,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  final _formKey = GlobalKey<FormState>();
  bool imageChanged=false;
  File? image;
  void getimage() async {
    image = await downloadImageToFile(widget.profileImageUrl);
    log(image!.path);
    setState(() {});
  }

  @override
  void initState() {
    getimage();

    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _mobileController = TextEditingController(text: widget.mobile.toString());
    super.initState();
  }

  void _saveProfile() {
    // Save logic here (e.g. call API or update DB)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppPallete.gradient2,
        content: Text('Profile updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local=AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:  Text(local.editProfile,),
        backgroundColor: AppPallete.gradient2,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileState) {
            _saveProfile();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
          }
        },
        builder: (context, state) {
         if(state is EditLoadingState){
          return const Center(child: CircularProgressIndicator());
         }else{
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: Stack(alignment: Alignment.bottomRight, children: [
                      GestureDetector(
                          onTap: () async {
                            
                            //  File? x=await pickImage();
                            //  if(image!.path!=x!.path){
                            //     image=x;
                            //      imageChanged = true;
                            //  }else{
                            //   image=x;
                            //  }
                            image = await pickImage();
                            imageChanged=true;
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage:
                                image != null ? FileImage(image!) : null,
                            child: image == null
                                ? const Icon(Iconsax.profile_circle, size: 50)
                                : null,
                          )
                          //               child:(image != null)
                          // ? Image.file(image!, fit: BoxFit.cover):

                          ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child:
                            Icon(Iconsax.edit_2, color: Colors.green, size: 20),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration:  InputDecoration(labelText: local.fullName),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "empty field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  //TextFormField(
                  //   controller: _emailController,
                  //   decoration: const InputDecoration(labelText: 'Email'),
                  // ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppPallete.gradient2,
                          content: Text("⚠️ You cannot edit it"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.lock_outline,
                              color: Colors.grey, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            widget.email,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value!.length != 10) {
                        return "wrong mobile no!!";
                      } else if (value.isEmpty) {
                        return "empty field";
                      } else {
                        return null;
                      }
                    },
                    controller: _mobileController,
                    decoration:
                        InputDecoration(labelText:local.phone ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50),
                      backgroundColor: AppPallete.gradient1, // button color
                      foregroundColor: Colors.white, // text/icon color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // rounded corners
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final userid =
                            (context.read<UserCubit>().state as UserLoggedIn)
                                .user
                                .id;
                        
                        context.read<ProfileBloc>().add(EditProfileDataEvent(
                            id: userid,
                            email: _emailController.text,
                            imageurl: image!,
                            mobileno: int.parse(_mobileController.text),
                            name: _nameController.text,
                            imageChanged:imageChanged,imagenetwork: widget.profileImageUrl));
                      }

                      // Go back to ProfilePage
                    },
                    child:  Text(local.savedChanges),
                  ),
                ],
              ),
            ),
          );}
        },
      ),
    );
  }
}
