import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/add_visit/cubit/cubit/add_or_update_visit_cubit.dart';
import 'package:rtm/features/visit_tracker/add_visit/form_field_label.dart';
import 'package:rtm/features/visit_tracker/add_visit/input_form_field.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/shared/services/hive_service.dart';
import 'package:rtm/shared/views/_index.dart';
import 'package:rtm/utils/_index.dart';
import 'package:rtm/utils/singletons.dart';

class AddOrUpdateVisit extends StatefulWidget {
  const AddOrUpdateVisit({
    this.isEdit = false,
    this.visit,
    super.key,
  });

  final bool isEdit;
  final CustomerVisit? visit;

  @override
  State<AddOrUpdateVisit> createState() => _AddOrUpdateVisitState();
}

class _AddOrUpdateVisitState extends State<AddOrUpdateVisit> {
  late List<Activity> fetchedActivities;
  late List<Customer> fetchedCustomers;

  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _visitDateController = TextEditingController();
  late DateTime? pickedDate;
  late TimeOfDay? pickedTime;

  final activitiesDoneNotifier = ValueNotifier<List<Activity>>([]);

  @override
  void initState() {
    super.initState();

    fetchedActivities = getIt<HiveService>().getActivities();
    fetchedCustomers = getIt<HiveService>().getCustomers();

    if (widget.isEdit) {
      _customerNameController.text = widget.visit?.customerName ?? '';
      _statusController.text = widget.visit?.status ?? '';
      _locationController.text = widget.visit?.location ?? '';
      _notesController.text = widget.visit?.notes ?? '';
      _visitDateController.text =
          Misc.formatDate(widget.visit?.visitDate ?? '');

      activitiesDoneNotifier.value = [
        ...widget.visit?.activitiesDone.map(
              (e) => fetchedActivities
                  .firstWhere((activity) => activity.description == e),
            ) ??
            <Activity>[],
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrUpdateVisitCubit, AddOrUpdateVisitState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (isEdit) {
            GoRouter.of(context).pop();
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppTheme.kErrorColor,
                content: Text(
                  message,
                  style: const TextStyle(
                    color: AppTheme.kBackgroundColor,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Scaffold(
        appBar: SingleTitleAppBar(
          title: widget.isEdit ? 'Edit Visit' : 'Add Visit',
          actions: [
            BlocBuilder<AddOrUpdateVisitCubit, AddOrUpdateVisitState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => TextButton(
                    onPressed: () => {},
                    child: Text(
                      widget.isEdit ? 'Update...' : 'Submit...',
                      style: TextStyle(
                        fontFamily: 'Graphik',
                        color: AppTheme.kPrimaryColor.addOpacity(.5),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  orElse: () => TextButton(
                    onPressed: () => addOrUpdateVisit(isEdit: widget.isEdit),
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
                );
              },
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
              InputFormField(
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
              Column(
                children: [
                  ...fetchedActivities.map((activity) {
                    return ValueListenableBuilder(
                      valueListenable: activitiesDoneNotifier,
                      builder: (context, activitiesDone, child) {
                        return CheckboxListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          title: Text(activity.description),
                          value: activitiesDone.contains(activity),
                          onChanged: (value) {
                            setState(() {
                              if (value ?? false) {
                                activitiesDoneNotifier.value.add(activity);
                              } else {
                                activitiesDoneNotifier.value.remove(activity);
                              }
                            });
                          },
                        );
                      },
                    );
                  }),
                ],
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
      ),
    );
  }

  void addOrUpdateVisit({bool isEdit = false}) {
    final fetchedVisits = getIt<HiveService>().getVisits();

    final customerId = fetchedCustomers
        .firstWhere(
          (customer) => customer.name == _customerNameController.text,
          orElse: () => Customer(id: 0, name: '', createdAt: ''),
        )
        .id;

    final activitiesDone = activitiesDoneNotifier.value
        .map((activity) => activity.id)
        .map((id) => id.toString())
        .toList();
    if (isEdit) {
      getIt<HiveService>().persistVisitDetails(
        Visit(
          id: widget.visit?.id ?? 0,
          customerId: customerId,
          status: _statusController.text.trim(),
          location: _locationController.text.trim(),
          activitiesDone: activitiesDone,
          notes: _notesController.text.trim(),
          visitDate: Misc.displayToIso(_visitDateController.text.trim()),
        ),
      );
    } else {
      getIt<HiveService>().persistVisitDetails(
        Visit(
          id: fetchedVisits.length + 1,
          customerId: customerId,
          status: _statusController.text.trim(),
          location: _locationController.text.trim(),
          activitiesDone: activitiesDone,
          notes: _notesController.text.trim(),
          visitDate: Misc.displayToIso(_visitDateController.text.trim()),
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
    }
    context.read<AddOrUpdateVisitCubit>().addOrUpdateVisit(isEdit: isEdit);
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
