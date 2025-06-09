import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_vaidya/models/plant_models.dart';
import 'package:plant_vaidya/utils/image_picker_utils.dart';

class PlantAnalysisForm extends StatefulWidget {
  final Function(XFile imageFile, String description, AnalysisAction action)
      onSubmit;
  final bool isProcessing;

  const PlantAnalysisForm({
    super.key,
    required this.onSubmit,
    required this.isProcessing,
  });

  @override
  State<PlantAnalysisForm> createState() => _PlantAnalysisFormState();
}

class _PlantAnalysisFormState extends State<PlantAnalysisForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  XFile? _imageFile;
  AnalysisAction _selectedAction = AnalysisAction.disease;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await ImagePickerUtils.pickImage(source);
    if (pickedFile != null) {
      if (!mounted) return;
      if (await pickedFile.length() > 5 * 1024 * 1024) {
        // 5MB limit
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Image too large. Please select an image smaller than 5MB.')),
        );
        return;
      }
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _handleSubmit() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
          _imageFile!, _descriptionController.text, _selectedAction);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Plant Helper',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Upload an image and choose an action.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text('Plant Image',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext bc) {
                        return SafeArea(
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                  leading: const Icon(Icons.photo_library),
                                  title: const Text('Gallery'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.of(context).pop();
                                  }),
                              ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined,
                                  size: 50, color: Colors.grey),
                              Text('Tap to select image'),
                              Text('PNG, JPG, WEBP. Max 5MB.',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Description (Optional)',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'e.g., Yellow spots on leaves, wilting stems...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Text('Choose Action',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              RadioListTile<AnalysisAction>(
                title: const Text('Analyze Disease'),
                value: AnalysisAction.disease,
                groupValue: _selectedAction,
                onChanged: (AnalysisAction? value) {
                  if (value != null) {
                    setState(() {
                      _selectedAction = value;
                    });
                  }
                },
                secondary: const Icon(Icons.bug_report_outlined),
              ),
              RadioListTile<AnalysisAction>(
                title: const Text('Get Plant Info'),
                value: AnalysisAction.info,
                groupValue: _selectedAction,
                onChanged: (AnalysisAction? value) {
                  if (value != null) {
                    setState(() {
                      _selectedAction = value;
                    });
                  }
                },
                secondary: const Icon(Icons.info_outline),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: widget.isProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)))
                    : Icon(_selectedAction == AnalysisAction.disease
                        ? Icons.biotech
                        : Icons.search),
                label: Text(widget.isProcessing
                    ? 'Processing...'
                    : _selectedAction == AnalysisAction.disease
                        ? 'Analyze Disease'
                        : 'Get Info'),
                onPressed: widget.isProcessing || _imageFile == null
                    ? null
                    : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
