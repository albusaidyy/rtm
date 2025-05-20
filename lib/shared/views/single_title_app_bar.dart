import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/extensions.dart';

class SingleTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SingleTitleAppBar({
    required this.title,
    super.key,
    this.actions,
    this.isHome = false,
    this.isDefaultIcon,
    this.onTap,
  });

  final String title;
  final List<Widget>? actions;
  final bool? isDefaultIcon;
  final VoidCallback? onTap;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      shadowColor: AppTheme.kSecondaryGreyColor.addOpacity(0.25),
      backgroundColor: AppTheme.kBackgroundColor,
      surfaceTintColor: AppTheme.kBackgroundColor,
      elevation: 3,
      leadingWidth: isHome ? null : 50,
      titleSpacing: isHome ? null : 0,
      leading: isHome
          ? null
          : Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: InkWell(
                onTap: onTap ?? () => GoRouter.of(context).pop(),
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: AppTheme.kBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Icon(
                      isDefaultIcon ?? true
                          ? Icons.arrow_back_ios
                          : Icons.close,
                      color: AppTheme.kBlackColor,
                    ),
                  ),
                ),
              ),
            ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.kBlackColor,
          fontSize: 18,
          fontFamily: 'Graphik',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
