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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick document')),
        );
      }
    }
  }

  void _showImagePreview() {
    if (_selectedFile == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the sheet to be as large as needed
      builder: (context) => Container(
        height:
            MediaQuery.of(context).size.height * 0.8, // 80% of screen height
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Image preview
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4,
                child: Image.file(
                  _selectedFile!,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Close button (cross icon)
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context), // Close the bottom sheet
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  context, "Please select a document category", KColors.error);
              return;
            }
            if (_selectedFile == null && widget.document == null) {
              KSnackbar.CustomSnackbar(
                  context, "Please upload a document", KColors.error);
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
                "Document",
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
                          KValidator.validateEmptyText("Title", value),
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    SizedBox(height: KSizes.sm),
                    DottedDivider(),
                    SizedBox(height: KSizes.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Document Category",
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
                          validator: (value) =>
                              KValidator.validateEmptyText("Document", value),
                          decoration: InputDecoration(
                            labelText: "Document",
                            suffixIcon: Icon(Icons.note_outlined),
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
