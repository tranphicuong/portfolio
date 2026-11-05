import 'package:go_router/go_router.dart';

import '../utils/constants.dart';
import '../utils/page_transitions.dart';
import '../views/contact_page.dart';
import '../views/home_page.dart';
import '../views/not_found_page.dart';
import '../views/projects_page.dart';
import '../views/resume_page.dart';
import '../views/skills_page.dart';
import '../widgets/app_shell.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  errorBuilder: (context, state) =>
      NotFoundPage(location: state.uri.toString()),
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => buildTransitionPage(
            state: state,
            child: const HomePage(),
            transition: AppTransition.fade,
          ),
        ),
        GoRoute(
          path: AppRoutes.resume,
          pageBuilder: (context, state) => buildTransitionPage(
            state: state,
            child: const ResumePage(),
            transition: AppTransition.slideFromRight,
          ),
        ),
        GoRoute(
          path: AppRoutes.skills,
          pageBuilder: (context, state) => buildTransitionPage(
            state: state,
            child: const SkillsPage(),
            transition: AppTransition.scale,
          ),
        ),
        GoRoute(
          path: AppRoutes.projects,
          pageBuilder: (context, state) => buildTransitionPage(
            state: state,
            child: const ProjectsPage(),
            transition: AppTransition.slideUp,
          ),
        ),
        GoRoute(
          path: AppRoutes.contact,
          pageBuilder: (context, state) => buildTransitionPage(
            state: state,
            child: const ContactPage(),
            transition: AppTransition.slideFromRight,
          ),
        ),
      ],
    ),
  ],
);
