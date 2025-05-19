import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/views/_index.dart';
import 'package:rtm/shared/views/single_title_app_bar.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/misc.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  static final Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetVisitsCubit>().getVisits();
    });
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

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12,),
                    child: VisitStatWidget(
                        completedPercent: completedPercent,
                        pendingPercent: pendingPercent,
                        cancelledPercent: cancelledPercent,),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: visits.length,
                      itemBuilder: (context, index) {
                        final visit = visits[index];
                        return VisitCard(
                          visit: visit,
                          isExpanded: _expandedStates[visit.id] ?? false,
                          onToggle: (expanded) {
                            setState(() {
                              _expandedStates[visit.id] = expanded;
                            });
                          },
                        );
                      },
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
