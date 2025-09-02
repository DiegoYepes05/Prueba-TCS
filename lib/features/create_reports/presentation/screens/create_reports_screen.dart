import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prueba_tcs/config/extensions/app_toastification_extension.dart';
import 'package:prueba_tcs/config/helpers/validators.dart';
import 'package:prueba_tcs/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:prueba_tcs/features/auth/presentation/widgets/widgets.dart';
import 'package:prueba_tcs/features/create_reports/presentation/bloc/create_reports_bloc.dart';
import 'package:prueba_tcs/features/home/domain/domain.dart';
import 'package:prueba_tcs/features/service_locator.dart';

class CreateReportsScreen extends StatefulWidget {
  final Category category;
  const CreateReportsScreen({required this.category, super.key});

  @override
  State<CreateReportsScreen> createState() => _CreateReportsScreenState();
}

class _CreateReportsScreenState extends State<CreateReportsScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;
  late final TextEditingController _dateController;
  ReportEntity _reportEntity = ReportEntity.empty();
  @override
  void initState() {
    super.initState();
    _initReportEntity();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
  }

  void _initReportEntity() {
    setState(() {
      _reportEntity = _reportEntity.copyWith(category: widget.category);
    });
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  void setReportEntity(ReportEntity reportEntity) {
    setState(() {
      _reportEntity = reportEntity;
    });
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateReportsBloc>(
      create: (BuildContext context) => sl<CreateReportsBloc>(),
      child: BlocConsumer<CreateReportsBloc, CreateReportsState>(
        listener: (BuildContext context, CreateReportsState state) {
          if (state is SuccessReportsState) {
            context
              ..showSuccessToastification(message: 'Reporte creado con exito')
              ..pop();
          }
        },
        builder: (BuildContext context, CreateReportsState state) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.category.name)),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,

                child: Column(
                  spacing: 16,
                  children: <Widget>[
                    CustomTextFormField(
                      controller: _titleController,
                      label: 'Titulo',
                      validator: Validators.validateTitle,
                      onSaved: (String? value) {
                        _reportEntity = _reportEntity.copyWith(title: value);
                      },
                    ),
                    CustomTextFormField(
                      controller: _descriptionController,
                      label: 'Descripcion',
                      validator: Validators.validateDescription,
                      onSaved: (String? value) {
                        _reportEntity = _reportEntity.copyWith(
                          description: value,
                        );
                      },
                    ),
                    CustomTextFormField(
                      controller: _amountController,
                      label: 'Monto',
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      validator: Validators.validateAmount,
                      onSaved: (String? value) {
                        _reportEntity = _reportEntity.copyWith(
                          amount: double.parse(value ?? '0'),
                        );
                      },
                    ),
                    CustomTextFormField(
                      validator: Validators.validateDate,
                      onSaved: (String? value) {
                        _reportEntity = _reportEntity.copyWith(
                          date: DateFormat('dd/MM/yyyy').parse(value ?? ''),
                        );
                      },
                      controller: _dateController,
                      label: 'Fecha',
                      readOnly: true,
                      onTap: _selectDate,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  sl<CreateReportsBloc>().add(
                    CreateReportsSaveEvent(reportEntity: _reportEntity),
                  );
                }
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
