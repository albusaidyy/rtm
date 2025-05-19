import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/features/visit_tracker/visits/views/_index.dart';
import 'package:rtm/shared/views/search_form_field.dart';
import 'package:rtm/shared/views/single_title_app_bar.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/misc.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  final _searchController = TextEditingController();
  final visitsNotifier = ValueNotifier<List<Visit>>([]);
  final searchNotifier = ValueNotifier<List<Visit>>([]);

  static final Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetVisitsCubit>().getVisits();

      _searchController.addListener(searchForm);
    });
  }

  void searchForm() {
    searchNotifier.value = List.of(
      visitsNotifier.value.where(
        (element) => element.location
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: const SingleTitleAppBar(
        title: 'Visits',
        isHome: true,
      ),
      body: BlocBuilder<GetVisitsCubit, GetVisitsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (visits) {
              final completedPercent =
                  Misc.getStatusPercent(visits, 'completed');

              final pendingPercent = Misc.getStatusPercent(visits, 'pending');

              final cancelledPercent =
                  Misc.getStatusPercent(visits, 'cancelled');
              visitsNotifier.value = visits.reversed.toList();

              searchForm();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: VisitStatWidget(
                      completedPercent: completedPercent,
                      pendingPercent: pendingPercent,
                      cancelledPercent: cancelledPercent,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            height: 40,
                            child: SearchFormField(
                              hintText: 'Search by name',
                              controller: _searchController,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ValueListenableBuilder<List<Visit>>(
                            valueListenable: searchNotifier,
                            builder: (context, displayList, _) {
                              return ListView.builder(
                                itemCount: displayList.length,
                                itemBuilder: (context, index) {
                                  final visit = displayList[index];
                                  return VisitCard(
                                    visit: visit,
                                    isExpanded:
                                        _expandedStates[visit.id] ?? false,
                                    onToggle: (expanded) {
                                      setState(() {
                                        _expandedStates[visit.id] = expanded;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error) => Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
