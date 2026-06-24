import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../services/upload_service.dart';
import '../widgets/luxury_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_screen.dart';
import 'payment_screen.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});
  static const routeName = '/file-upload';

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  static const _documentTypes = ['CNIC Front', 'CNIC Back', 'Supporting Document'];
  final Map<String, PlatformFile> _files = {};
  bool _loading = false;
  List<String> _serials = [];

  Future<void> _pickFile(String documentType) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.single;
    final extension = file.extension?.toLowerCase() ?? '';
    if (!['jpg', 'jpeg', 'png', 'pdf'].contains(extension)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Only JPG, PNG and PDF files are allowed.')));
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File size must be under 5 MB.')));
      return;
    }
    setState(() {
      _files[documentType] = file;
      _serials = [];
    });
  }

  Future<void> _uploadAll() async {
    final missing = ['CNIC Front', 'CNIC Back'].where((type) => !_files.containsKey(type)).toList();
    if (missing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select ${missing.join(' and ')} first.')));
      return;
    }

    setState(() => _loading = true);
    try {
      final payload = _files.entries.map((entry) {
        final file = entry.value;
        return UploadFilePayload(
          documentType: entry.key,
          fileName: file.name,
          sizeBytes: file.size,
          extension: file.extension?.toLowerCase() ?? '',
        );
      }).toList();

      final serials = await UploadService.saveDocumentMetadata(files: payload);
      if (!mounted) return;
      setState(() => _serials = serials);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Documents submitted for admin verification.')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton.filledTonal(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
          const SizedBox(height: 10),
          const Text('UPLOAD\nDOCUMENTS', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.primaryText, height: 1.1)),
          const SizedBox(height: 8),
          const Text('Select all required documents once, then submit them together for admin verification.', style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          LuxuryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.lightPurple.withOpacity(0.55), borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.lavender)),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_rounded, color: AppColors.primaryPurple),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Storage paid plan is not used. This screen saves file name, type, size and unique serial number in Firestore for FYP demo and admin verification.',
                          style: TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                ..._documentTypes.map((type) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _DocumentPickerCard(
                        title: type,
                        requiredText: type == 'Supporting Document' ? 'Optional PDF/Image' : 'Required',
                        file: _files[type],
                        onPick: () => _pickFile(type),
                        onClear: _files[type] == null
                            ? null
                            : () => setState(() {
                                  _files.remove(type);
                                  _serials = [];
                                }),
                      ),
                    )),
                if (_serials.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.10), borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.successGreen.withOpacity(0.25))),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_rounded, color: AppColors.successGreen),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Submitted successfully. Serials: ${_serials.join(', ')}', style: const TextStyle(color: AppColors.successGreen, fontWeight: FontWeight.w900))),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                PrimaryButton(text: 'UPLOAD ALL DOCUMENTS', icon: Icons.upload_file_rounded, loading: _loading, onPressed: _uploadAll),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, PaymentScreen.routeName),
                  child: const Center(child: Text('Continue to Payment', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w900))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentPickerCard extends StatelessWidget {
  const _DocumentPickerCard({
    required this.title,
    required this.requiredText,
    required this.file,
    required this.onPick,
    this.onClear,
  });

  final String title;
  final String requiredText;
  final PlatformFile? file;
  final VoidCallback onPick;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final selected = file != null;
    return InkWell(
      onTap: onPick,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.successGreen.withOpacity(0.08) : AppColors.lightPurple.withOpacity(0.45),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: selected ? AppColors.successGreen.withOpacity(0.35) : AppColors.lavender),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(gradient: selected ? null : AppColors.gradient, color: selected ? AppColors.successGreen.withOpacity(0.16) : null, borderRadius: BorderRadius.circular(16)),
              child: Icon(selected ? Icons.check_circle_rounded : Icons.cloud_upload_rounded, color: selected ? AppColors.successGreen : Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.primaryText)),
                  const SizedBox(height: 4),
                  Text(selected ? file!.name : 'Tap to choose file • $requiredText', style: const TextStyle(color: AppColors.secondaryText, fontWeight: FontWeight.w700, fontSize: 12)),
                  const SizedBox(height: 3),
                  const Text('JPG, PNG, PDF • Max 5 MB', style: TextStyle(color: AppColors.hintText, fontWeight: FontWeight.w600, fontSize: 11)),
                ],
              ),
            ),
            if (onClear != null)
              IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.close_rounded, color: AppColors.errorRed),
              )
            else
              const Icon(Icons.chevron_right_rounded, color: AppColors.hintText),
          ],
        ),
      ),
    );
  }
}
