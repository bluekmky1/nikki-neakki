import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../common/widgets/button/bottom_sheet_row_button_widget.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    required this.pickedImage,
    super.key,
    this.onCameraTap,
    this.onGalleryTap,
    this.width = double.infinity,
    this.height = 200.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.placeholder = '사진 추가',
    this.placeholderIcon = Icons.add_photo_alternate_outlined,
    this.onDeleteTap,
  });

  final XFile pickedImage;
  final VoidCallback? onCameraTap;
  final VoidCallback? onGalleryTap;
  final VoidCallback? onDeleteTap;
  final double width;
  final double height;
  final EdgeInsets margin;
  final String placeholder;
  final IconData placeholderIcon;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BottomSheetRowButtonWidget(
                      title: '카메라',
                      icon: Icons.camera_alt,
                      onTap: onCameraTap,
                    ),
                    BottomSheetRowButtonWidget(
                      title: '갤러리',
                      icon: Icons.photo_library,
                      onTap: onGalleryTap,
                    ),
                    if (pickedImage.path.isNotEmpty)
                      BottomSheetRowButtonWidget(
                        title: '사진 삭제',
                        icon: Icons.delete,
                        color: AppColors.red,
                        onTap: onDeleteTap,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
            color: AppColors.gray300,
            borderRadius: BorderRadius.circular(16),
          ),
          child: pickedImage.path.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(pickedImage.path),
                    width: width,
                    height: height,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      Icon(
                        placeholderIcon,
                        size: 24,
                        color: AppColors.gray600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        placeholder,
                        style: AppTextStyles.textR14.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      );
}
