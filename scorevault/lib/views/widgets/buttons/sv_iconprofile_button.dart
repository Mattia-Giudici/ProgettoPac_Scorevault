import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SvIconprofileButton extends StatelessWidget {
  final double radius;
  final String imageUrl;
  final VoidCallback? onPressed;
  final bool enableImagePicker;
  final ImagePickerFunction? customImagePickerFunction;

  const SvIconprofileButton({
    Key? key,
    required this.radius,
    required this.imageUrl,
    this.onPressed,
    this.enableImagePicker = false,
    this.customImagePickerFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enableImagePicker
          ? () async {
              if (customImagePickerFunction != null) {
                await customImagePickerFunction!();
              } else {
                await _defaultImagePicker(context);
              }
              if (onPressed != null) {
                onPressed!();
              }
            }
          : onPressed,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: imageUrl.isEmpty
            ? Icon(
                Icons.person_add_alt_rounded,
                size: radius * 0.8, // 80% del raggio
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              )
            : ClipOval(
                child: Image.network(
                  imageUrl,
                  width: radius * 2,
                  height: radius * 2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.person,
                    size: radius * 0.8,
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _defaultImagePicker(BuildContext context) async {
    final picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Qui potresti usare un provider o callback per gestire l'immagine selezionata
        // Ad esempio: Provider.of<ProfileImageProvider>(context, listen: false).setImage(image);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore durante la selezione dell\'immagine')),
      );
    }
  }
}

typedef ImagePickerFunction = Future<void> Function();
