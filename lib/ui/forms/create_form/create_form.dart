import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/di/service_locator.dart';
import 'package:projectunity/ui/forms/create_form/bloc/create_form_bloc.dart';
import 'package:projectunity/ui/widget/employee_details_textfield.dart';

import '../../../data/configs/text_style.dart';

class CreateFromPage extends StatelessWidget {
  const CreateFromPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateFormBloc>(),
      child: const CreateFormScreen(),
    );
  }
}

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Form"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const FieldTitle(
            title: 'Title',
          ),
          const FieldEntry(),
          const FieldTitle(
            title: 'Description',
          ),
          const FieldEntry(),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Limit To 1 Response',
              textAlign: TextAlign.start, style: AppFontStyle.labelGrey),
              Switch(value: true, onChanged: (value) {})
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
