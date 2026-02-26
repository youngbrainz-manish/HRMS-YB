import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommonImagePicker {
  static final ImagePicker _picker = ImagePicker();

  /// OPEN CAMERA/GALLERY POPUP
  static Future<File?> showImageSourcePicker(BuildContext context) async {
    return await showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _optionTile(
                  icon: Icons.camera_alt,
                  title: "Camera",
                  onTap: () async {
                    final file = await _pickImage(ImageSource.camera);
                    Navigator.pop(context, file);
                  },
                ),
                _optionTile(
                  icon: Icons.photo,
                  title: "Gallery",
                  onTap: () async {
                    final file = await _pickImage(ImageSource.gallery);
                    Navigator.pop(context, file);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// IMAGE PICKER
  static Future<File?> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile == null) return null;

    return File(pickedFile.path);
  }

  /// UI TILE
  static Widget _optionTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 28, child: Icon(icon, size: 26)),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}
