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
import 'package:prueba_tcs/features/details_reports/presentation/bloc/detail_reports_bloc.dart';
import 'package:prueba_tcs/features/reports/domain/domain.dart';
import 'package:prueba_tcs/features/service_locator.dart';
import 'package:shared/entities/status.dart';

class DetailsReportsScreen extends StatefulWidget {
  final String id;
  const DetailsReportsScreen({required this.id, super.key});

  @override
  State<DetailsReportsScreen> createState() => _DetailsReportsScreenState();
}

class _DetailsReportsScreenState extends State<DetailsReportsScreen> {
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
    setState(() {});
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

  void _initForm(ReportEntity reportEntity) {
    _titleController.text = reportEntity.title;
    _descriptionController.text = reportEntity.description;
    _amountController.text = reportEntity.amount.toString();
    _dateController.text = DateFormat('dd/MM/yyyy').format(reportEntity.date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailReportsBloc>(
      create: (BuildContext context) =>
          sl<DetailReportsBloc>()..add(GetReportByIdEvent(id: widget.id)),
      child: BlocConsumer<DetailReportsBloc, DetailReportsState>(
        listener: (BuildContext context, DetailReportsState state) {
          if (state.status == Status.success) {
            setReportEntity(state.report!);
            _initForm(state.report!);
          }
          if (state.reportStatus == Status.success) {
            context
              ..showSuccessToastification(
                message: 'Reporte actualizado exitosamente',
              )
              ..pop();
          }
        },
        builder: (BuildContext context, DetailReportsState state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Detalle del registro'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    context.read<DetailReportsBloc>().add(ToggleEditEvent());
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,

                child: Column(
                  spacing: 16,
                  children: <Widget>[
                    CustomTextFormField(
                      enabled: state.isEditing,
                      controller: _titleController,
                      label: 'Titulo',
                      validator: Validators.validateTitle,
                      onSaved: (String? value) {
                        _reportEntity = _reportEntity.copyWith(title: value);
                      },
                    ),
                    CustomTextFormField(
                      enabled: state.isEditing,
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
                      enabled: state.isEditing,
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
                      enabled: state.isEditing,
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
                    IgnorePointer(
                      ignoring: !state.isEditing,
                      child: DropdownButton<Category>(
                        value: _reportEntity.category,
                        items: Category.values.map((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Text(category.name),
                          );
                        }).toList(),
                        onChanged: (Category? value) {
                          setReportEntity(
                            _reportEntity.copyWith(category: value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,

            floatingActionButton: state.isEditing
                ? IgnorePointer(
                    ignoring: state is LoadingReportsState,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          context.read<DetailReportsBloc>().add(
                            UpdateReportEvent(report: _reportEntity),
                          );
                        }
                      },
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text(
                        'Guardar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
