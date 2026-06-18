import 'package:crud_app/src/core/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_cubit.dart';
import 'home_navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) {
        final navigator = HomeNavigator(context);
        return HomeCubit(
          navigator: navigator,
        )..init();
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (prev, current) => prev.activeTab != current.activeTab,
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.activeTab,
            children: [
              _buildCodingConventionsTab(context),
              _buildScreenBuilderTab(context),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.activeTab,
            onTap: (index) => context.read<HomeCubit>().changeTab(index),
            selectedItemColor: context.colors.primary,
            unselectedItemColor: context.colors.outline,
            backgroundColor: context.colors.surfaceContainer,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.rule),
                label: 'Coding Conventions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize),
                label: 'Screen Builder',
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================
  // Coding Conventions Tab View
  // ==========================================
  Widget _buildCodingConventionsTab(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coding Conventions',
          style: context.textThemes.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInfoBanner(
            context,
            'UI Development Rules',
            'Mandatory coding standards defined in .agents/coding-conventions/SKILL.md to ensure maintainability, scalability, and design consistency.',
            Icons.verified_user,
          ),
          const SizedBox(height: 20),
          _buildConventionSection(
            context,
            '1. Localization (l10n)',
            'NEVER hardcode strings in the UI. All user-facing text must be externalized using the localization system.',
            '// ❌ Incorrect\nText("Add Transaction")\n\n// ✅ Correct\nText(context.s.addTransaction)',
          ),
          _buildConventionSection(
            context,
            '2. Common Widgets',
            'Prioritize using existing common widgets (like AppTextField, AppFilledButton, AppSvgImage) to guarantee styling and theme consistency.',
            '// ❌ Incorrect\nElevatedButton(child: Text("Submit"))\n\n// ✅ Correct\nAppFilledButton(text: context.s.submit)',
          ),
          _buildConventionSection(
            context,
            '3. Color & Theme Management',
            'Colors must be centralized and accessed via the Theme. Direct Color(0xFF...) or Colors.blue usage is strictly prohibited.',
            '// ❌ Incorrect\nContainer(color: Color(0xFF00D09E))\n\n// ✅ Correct\nContainer(color: context.colors.primary)',
          ),
          _buildConventionSection(
            context,
            '4. Form Validation & Utilities',
            'Decouple all validation logic and visual picker triggers. Consolidate and encapsulate all validators in AppValidators.',
            '// ✅ Correct\nvalidator: (val) => AppValidators.validateEmail(context, val)',
          ),
          _buildConventionSection(
            context,
            '5. Modularity & Granular Layouts',
            'Avoid creating monolithic page files. Slice large layout trees into distinct, reusable private module widgets inside a local widget/ directory.',
            '// Feature Structure\nlib/src/presentation/screens/welcome/\n├── welcome_page.dart\n└── widget/\n    └── welcome_form.dart',
          ),
        ],
      ),
    );
  }

  // ==========================================
  // Screen Builder Tab View
  // ==========================================
  Widget _buildScreenBuilderTab(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Screen Builder',
          style: context.textThemes.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildInfoBanner(
            context,
            'MVVM + Clean Architecture',
            'Folder blueprint and core architectural guidelines defined in .agents/flutter-screen-builder/SKILL.md to construct new screens.',
            Icons.architecture,
          ),
          const SizedBox(height: 20),
          _buildStructureCard(context),
          const SizedBox(height: 16),
          _buildComponentCard(
            context,
            '1. Navigator (routing)',
            'Responsible for managing screen transitions, dialog triggers, and back actions. Extends BaseNavigator.',
            'class WelcomeNavigator extends BaseNavigator {\n  WelcomeNavigator(super.context);\n  void toHome() => goNamed(AppRouters.home);\n}',
          ),
          _buildComponentCard(
            context,
            '2. State (immutable state)',
            'Represents the visual state of the screen. Fields marked as final, Equatable extension, copyWith method.',
            'class SplashState extends Equatable {\n  final LoadStatus status;\n  const SplashState({this.status = LoadStatus.initial});\n  SplashState copyWith({LoadStatus? status}) => ...\n}',
          ),
          _buildComponentCard(
            context,
            '3. Cubit (business logic)',
            'Processes UI events and drives state transitions. Injected with navigator and repositories.',
            'class SplashCubit extends Cubit<SplashState> {\n  final SplashNavigator navigator;\n  SplashCubit(this.navigator) : super(const SplashState());\n}',
          ),
          _buildComponentCard(
            context,
            '4. Page (declarative UI)',
            'StatelessWidget entry provider (wraps BlocProvider) + private StatefulWidget content wrapper.',
            'class WelcomePage extends StatelessWidget {\n  const WelcomePage({super.key});\n  Widget build(BuildContext c) => BlocProvider(...);\n}',
          ),
        ],
      ),
    );
  }

  // ==========================================
  // Helper Component Builders
  // ==========================================
  Widget _buildInfoBanner(BuildContext context, String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colors.primary.withValues(alpha: 0.15), context.colors.primary.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: context.colors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: context.colors.primary),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textThemes.body16Semi.copyWith(color: context.colors.primary, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: context.textThemes.des12Re.copyWith(color: context.colors.onSurfaceContainer),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConventionSection(BuildContext context, String title, String description, String codeExample) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shadowColor: context.colors.outline.withValues(alpha: 0.15),
      color: context.colors.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textThemes.body16Semi.copyWith(fontWeight: FontWeight.bold, color: context.colors.onSurface),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: context.textThemes.des12Re.copyWith(color: context.colors.onSurfaceContainer, fontSize: 13.5),
            ),
            const SizedBox(height: 12.0),
            _buildCodeSnippet(context, codeExample),
          ],
        ),
      ),
    );
  }

  Widget _buildStructureCard(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: context.colors.outline.withValues(alpha: 0.15),
      color: context.colors.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Feature Directory Blueprint',
              style: context.textThemes.body16Semi.copyWith(fontWeight: FontWeight.bold, color: context.colors.onSurface),
            ),
            const SizedBox(height: 8.0),
            _buildCodeSnippet(
              context,
              'lib/src/presentation/screens/add_transaction/\n├── add_transaction_cubit.dart\n├── add_transaction_navigator.dart\n├── add_transaction_page.dart\n└── add_transaction_state.dart',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentCard(BuildContext context, String title, String description, String codeExample) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shadowColor: context.colors.outline.withValues(alpha: 0.15),
      color: context.colors.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textThemes.body16Semi.copyWith(fontWeight: FontWeight.bold, color: context.colors.onSurface),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: context.textThemes.des12Re.copyWith(color: context.colors.onSurfaceContainer, fontSize: 13.5),
            ),
            const SizedBox(height: 12.0),
            _buildCodeSnippet(context, codeExample),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeSnippet(BuildContext context, String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          code,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.lightGreenAccent,
          ),
        ),
      ),
    );
  }
}
