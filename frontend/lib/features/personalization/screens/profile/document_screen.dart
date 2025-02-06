import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/custom_screen/custom_screen.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/profile_detail_model.dart';
import 'package:frontend/features/personalization/providers/document_provider.dart';
import 'package:frontend/features/personalization/providers/profile_provider.dart';
import 'package:frontend/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key, this.document});
  final Document? document;
  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _documentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? _selectedFile;

  final List<String> _documentCategory = [
    "Citizenship",
    "CV",
  ];

  String? _selectedDocumentCategory;

  Future<void> _pickDocument() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedFile = File(pickedFile.path);
          _documentController.text = pickedFile.name;
        });
      }
    } catch (e) {
      print("Error picking document: $e");
      if (mounted) {
        KSnackbar.CustomSnackbar(
            context, "Failed to pick document", KColors.error);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.document != null) {
      _titleController.text = widget.document!.title ?? "";
      _selectedDocumentCategory = widget.document!.category;
      _documentController.text = widget.document!.file ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final documentProvider = Provider.of<DocumentProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    return FullScreenOverlay(
      isLoading: documentProvider.isLoading,
      child: CustomScreen(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (_selectedDocumentCategory == null) {
              KSnackbar.CustomSnackbar(
                  context, "${l10n.select_document_category}", KColors.error);
              return;
            }
            if (_selectedFile == null && widget.document == null) {
              KSnackbar.CustomSnackbar(
                  context, "${l10n.upload_document}", KColors.error);
              return;
            }

            if (widget.document == null) {
              // ADD DOCUMENT
              documentProvider.addDocument(
                title: _titleController.text.trim(),
                category: _selectedDocumentCategory!,
                file: _selectedFile!,
                context: context,
                onSuccess: () async {
                  await profileProvider.fetchProfile(forceRefresh: true);
                  context.pop();
                },
              );
            } else {
              // UPDATE DOCUMENT
              documentProvider.updateDocument(
                documentId: widget.document!.id!,
                title: _titleController.text.trim(),
                category: _selectedDocumentCategory!,
                file: _selectedFile, // Only update if a new file is selected
                context: context,
                onSuccess: () async {
                  await profileProvider.fetchProfile(forceRefresh: true);
                  context.pop();
                },
              );
            }
          }
        },
        buttonText: l10n.submit,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: KSizes.md, vertical: KSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                "${l10n.document}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: KSizes.fontSizeSm),
                      validator: (value) =>
                          KValidator.validateEmptyText("${l10n.title}", value),
                      decoration: InputDecoration(
                        labelText: "${l10n.title}",
                      ),
                    ),
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${l10n.add_document_category}",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: 18.sp,
                                  ),
                        ),
                        SizedBox(height: KSizes.sm),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _documentCategory.map((documentCategory) {
                            final isSelected =
                                _selectedDocumentCategory == documentCategory;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_selectedDocumentCategory ==
                                      documentCategory) {
                                    _selectedDocumentCategory = null;
                                  } else {
                                    _selectedDocumentCategory =
                                        documentCategory;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? KColors.secondary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? KColors.primary
                                        : KColors.grey,
                                  ),
                                ),
                                child: Text(
                                  documentCategory,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.md),
                    InkWell(
                      onTap: _pickDocument,
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: _documentController,
                          readOnly: true,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: KSizes.fontSizeSm),
                          validator: (value) => KValidator.validateEmptyText(
                              "${l10n.document}", value),
                          decoration: InputDecoration(
                            labelText: "${l10n.document}",
                            suffixIcon: Icon(Icons.insert_drive_file_outlined),
                          ),
                        ),
                      ),
                    ),
                    if (_selectedFile != null) ...[
                      SizedBox(height: KSizes.md),
                      GestureDetector(
                        // onTap: _showImagePreview,
                        onTap: () {
                          context.pushNamed(
                            RoutesConstant.imagePreview,
                            extra: {
                              'file': _selectedFile,
                              'image': null,
                              'isFile': true,
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedFile!,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: KSizes.defaultSpace),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
