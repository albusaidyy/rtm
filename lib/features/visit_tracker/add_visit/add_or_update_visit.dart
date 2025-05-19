import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/add_visit/form_field_label.dart';
import 'package:rtm/features/visit_tracker/add_visit/input_form_field.dart';
import 'package:rtm/features/visit_tracker/cubit/_index.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/shared/views/_index.dart';
import 'package:rtm/utils/_index.dart';

class AddOrUpdateVisit extends StatefulWidget {
  const AddOrUpdateVisit({this.isEdit = false, super.key});

  final bool isEdit;

  @override
  State<AddOrUpdateVisit> createState() => _AddOrUpdateVisitState();
}

class _AddOrUpdateVisitState extends State<AddOrUpdateVisit> {
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _visitDateController = TextEditingController();
  late DateTime? pickedDate;
  late TimeOfDay? pickedTime;

  final activitiesDone = <Activity>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SingleTitleAppBar(
        title: widget.isEdit ? 'Edit Visit' : 'Add Visit',
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              widget.isEdit ? 'Update' : 'Submit',
              style: const TextStyle(
                fontFamily: 'Graphik',
                color: AppTheme.kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      body: Container(
        color: AppTheme.kBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const FormFieldLabel(
              label: 'Customer Name',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            BlocBuilder<GetCustomersCubit, GetCustomersState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  error: (error) => FetchErrorWidget(
                    error: error,
                    onRetry: () {
                      context.read<GetCustomersCubit>().getCustomers();
                    },
                  ),
                  loaded: (customers) => InputFormField(
                    hintText:
                        '''Tap to select ${widget.isEdit ? 'Customer' : 'Customer Name'}''',
                    controller: _customerNameController,
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.expand_more,
                    ),
                    onTap: () {
                      GoRouter.of(context).push(
                        RtmRouter.selectCustomer,
                        extra: (Customer customer) {
                          setState(() {
                            _customerNameController.text = customer.name;
                          });
                        },
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            const FormFieldLabel(
              label: 'Staus',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            ColoredBox(
              color: AppTheme.kBackgroundColor,
              child: InputFormField(
                suffixIcon: const Icon(
                  Icons.expand_more,
                ),
                hintText: 'Tap to select status',
                controller: _statusController,
                readOnly: true,
                onTap: () {
                  _statusController.clear();
                  void selectedStatus(String status) {
                    setState(() {
                      _statusController.text = status;
                    });
                  }

                  GoRouter.of(context).push(
                    RtmRouter.selectStatus,
                    extra: selectedStatus,
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const FormFieldLabel(
              label: 'Location',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            ColoredBox(
              color: AppTheme.kBackgroundColor,
              child: InputFormField(
                hintText: 'Enter ${widget.isEdit ? 'Location' : 'Location'}',
                controller: _locationController,
                keyboardType: TextInputType.name,
              ),
            ),
            const SizedBox(height: 15),
            const FormFieldLabel(
              label: 'Activities  ',
              isRequired: false,
            ),
            const SizedBox(height: 10),
            BlocBuilder<GetActivitiesCubit, GetActivitiesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  error: (error) => FetchErrorWidget(
                    error: error,
                    onRetry: () {
                      context.read<GetActivitiesCubit>().getActivities();
                    },
                  ),
                  loaded: (activities) {
                    return Column(
                      children: [
                        ...activities.map((activity) {
                          return CheckboxListTile(
                            dense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            title: Text(activity.description),
                            value: activitiesDone.contains(activity),
                            onChanged: (value) {
                              setState(() {
                                if (value ?? false) {
                                  activitiesDone.add(activity);
                                } else {
                                  activitiesDone.remove(activity);
                                }
                              });
                            },
                          );
                        }),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            const FormFieldLabel(
              label: 'Notes',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            InputFormField(
              hintText: 'Enter ${widget.isEdit ? 'Notes' : 'Notes'}',
              controller: _notesController,
              keyboardType: TextInputType.name,
              isTextBox: true,
            ),
            const SizedBox(height: 15),
            const FormFieldLabel(
              label: 'Visit Date',
              isRequired: true,
            ),
            const SizedBox(height: 10),
            ColoredBox(
              color: AppTheme.kBackgroundColor,
              child: InputFormField(
                hintText: 'Tap to select visit date',
                controller: _visitDateController,
                readOnly: true,
                suffixIcon: const Icon(
                  CupertinoIcons.calendar,
                ),
                onTap: () async {
                  _visitDateController.clear();
                  // 1. Pick the date
                  final datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: pickerTheme,
                  );

                  if (datePicked != null) {
                    // 2. Pick the time
                    if (!context.mounted) return;
                    final timePicked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: pickerTheme,
                    );

                    if (timePicked != null) {
                      pickedTime = timePicked;
                      // 3. Combine date and time
                      final dateTime = DateTime(
                        datePicked.year,
                        datePicked.month,
                        datePicked.day,
                        timePicked.hour,
                        timePicked.minute,
                      );
                      _visitDateController.text =
                          dateTime.toDateDisplayFormat();
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Theme pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppTheme.kPrimaryColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.kPrimaryColor,
          ),
        ),
      ),
      child: child!,
    );
  }
}
