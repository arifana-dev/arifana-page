import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../projects/domain/project_item.dart';

class ProjectFormDialog extends StatefulWidget {
  const ProjectFormDialog({this.project, super.key});

  final ProjectItem? project;

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _roleController;
  late final TextEditingController _periodController;
  late final TextEditingController _tagsController;
  late final TextEditingController _highlightsController;
  late final TextEditingController _sortOrderController;
  late bool _isPublished;

  @override
  void initState() {
    super.initState();
    final project = widget.project;
    _titleController = TextEditingController(text: project?.title ?? '');
    _descriptionController =
        TextEditingController(text: project?.description ?? '');
    _roleController = TextEditingController(text: project?.role ?? '');
    _periodController = TextEditingController(text: project?.period ?? '');
    _tagsController =
        TextEditingController(text: project?.tags.join(', ') ?? '');
    _highlightsController =
        TextEditingController(text: project?.highlights.join('\n') ?? '');
    _sortOrderController =
        TextEditingController(text: '${project?.sortOrder ?? 0}');
    _isPublished = project?.isPublished ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _roleController.dispose();
    _periodController.dispose();
    _tagsController.dispose();
    _highlightsController.dispose();
    _sortOrderController.dispose();
    super.dispose();
  }

  void _save() {
    final project = ProjectItem(
      id: widget.project?.id ?? '',
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      role: _roleController.text.trim(),
      period: _periodController.text.trim(),
      tags: _tagsController.text
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(),
      highlights: _highlightsController.text
          .split('\n')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(),
      isPublished: _isPublished,
      sortOrder: int.tryParse(_sortOrderController.text.trim()) ?? 0,
    );
    Navigator.of(context).pop(project);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'Add Project' : 'Edit Project'),
      content: SizedBox(
        width: 560,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field(_titleController, 'Title'),
              _field(_descriptionController, 'Description', maxLines: 3),
              _field(_roleController, 'Role'),
              _field(_periodController, 'Period'),
              _field(_tagsController, 'Tags (comma separated)'),
              _field(_highlightsController, 'Highlights (one per line)',
                  maxLines: 5),
              _field(_sortOrderController, 'Sort order',
                  keyboardType: TextInputType.number),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Published', style: AppTextStyles.titleMedium),
                value: _isPublished,
                onChanged: (value) => setState(() => _isPublished = value),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _save, child: const Text('Save')),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
