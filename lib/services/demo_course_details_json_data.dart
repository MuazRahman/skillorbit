class CourseDetailsJsonData {
  final Map<String, Map<String, dynamic>> courseDetails = {
    'Flutter': {
      'description':
          'Flutter is Google\'s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
      'topics': [
        {
          'name': 'Widgets',
          'description':
              'Learn about Flutter widgets, the building blocks of the UI. Widgets describe what their view should look like given their current configuration and state.',
          'tutorialLink': 'https://flutter.dev/docs/development/ui/widgets',
          'subtopics': [
            {
              'name': 'Container',
              'description':
                  'A widget that combines common painting, positioning, and sizing of a child widget.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/Container-class.html',
              'quizQuestions': [
                {
                  'question':
                      'What is the primary purpose of Container widget?',
                  'options': [
                    'To hold and style child widgets',
                    'To manage app state',
                    'To handle navigation',
                    'To manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property controls Container padding?',
                  'options': ['margin', 'padding', 'width', 'height'],
                  'correctAnswerIndex': 1,
                },
                {
                  'question': 'Can Container have multiple children?',
                  'options': [
                    'Yes, always',
                    'No, only one child',
                    'Depends on configuration',
                    'Only in web apps',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question':
                      'What does Container decoration property control?',
                  'options': [
                    'Child widget behavior',
                    'Visual appearance like color and border',
                    'Network requests',
                    'Database operations',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question':
                      'Which widget is commonly used with Container for layout?',
                  'options': ['Row', 'Column', 'Center', 'All of the above'],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is the default size of a Container?',
                  'options': [
                    'Full screen',
                    'Size of child widget',
                    'Fixed 100x100',
                    'Invisible',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question': 'Can Container have constraints?',
                  'options': [
                    'Yes, using BoxConstraints',
                    'No, it\'s fixed size',
                    'Only width constraints',
                    'Only height constraints',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Container\'s parent widget typically?',
                  'options': ['Scaffold', 'MaterialApp', 'Row/Column', 'Any'],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which property controls Container margin?',
                  'options': ['padding', 'margin', 'border', 'decoration'],
                  'correctAnswerIndex': 1,
                },
                {
                  'question':
                      'What happens when Container has no child and no size?',
                  'options': [
                    'Throws error',
                    'Takes minimum size',
                    'Takes maximum available size',
                    'Becomes invisible',
                  ],
                  'correctAnswerIndex': 2,
                },
              ],
            },
            {
              'name': 'Text',
              'description':
                  'A widget that displays a string of text with single style.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/Text-class.html',
              'quizQuestions': [
                {
                  'question': 'What is the primary purpose of Text widget?',
                  'options': [
                    'Display styled text',
                    'Manage user input',
                    'Handle navigation',
                    'Manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property controls Text styling?',
                  'options': ['style', 'theme', 'decoration', 'format'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Text widget display multiple styles?',
                  'options': [
                    'Yes, with TextSpan',
                    'No, single style only',
                    'Depends on font',
                    'Only in web apps',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does Text overflow property control?',
                  'options': [
                    'Text alignment',
                    'Behavior when text is too long',
                    'Font size scaling',
                    'Text color changes',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question': 'Which widget is used for rich text?',
                  'options': [
                    'RichText',
                    'StyledText',
                    'FormattedText',
                    'AdvancedText',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Text textAlign property for?',
                  'options': [
                    'Horizontal alignment',
                    'Vertical alignment',
                    'Text direction',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Text widget handle localization?',
                  'options': [
                    'Yes, with proper setup',
                    'No, text is static',
                    'Only in English',
                    'Only with third-party packages',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Text maxLines property for?',
                  'options': [
                    'Limit text to specified lines',
                    'Increase font size',
                    'Add padding',
                    'Control scrolling',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property makes Text selectable?',
                  'options': [
                    'selectable',
                    'enableSelection',
                    'selectionEnabled',
                    'No property needed',
                  ],
                  'correctAnswerIndex': 2,
                },
                {
                  'question': 'What happens with Text softWrap false?',
                  'options': [
                    'Text stays on single line',
                    'Text becomes invisible',
                    'Text size decreases',
                    'Text becomes bold',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Row',
              'description':
                  'A widget that displays its children in a horizontal array.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/Row-class.html',
              'quizQuestions': [
                {
                  'question': 'What is the primary purpose of Row widget?',
                  'options': [
                    'Arrange children horizontally',
                    'Manage app state',
                    'Handle navigation',
                    'Manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property controls horizontal alignment?',
                  'options': [
                    'mainAxisAlignment',
                    'crossAxisAlignment',
                    'direction',
                    'alignment',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Row have unlimited children?',
                  'options': [
                    'Yes, but performance may suffer',
                    'No, limited to 10',
                    'No, limited to 5',
                    'Depends on device',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does Row mainAxisSize property control?',
                  'options': [
                    'How much space Row takes',
                    'Child widget size',
                    'Text size',
                    'Border thickness',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget is Row\'s vertical counterpart?',
                  'options': ['Column', 'List', 'Stack', 'Grid'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What happens with Row flexible children?',
                  'options': [
                    'They share available space',
                    'They become invisible',
                    'They stack vertically',
                    'They scroll automatically',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Row contain other Rows?',
                  'options': [
                    'Yes, nested layouts possible',
                    'No, only simple widgets',
                    'Only in web apps',
                    'Only with special setup',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Row crossAxisAlignment for?',
                  'options': [
                    'Vertical alignment of children',
                    'Horizontal alignment',
                    'Text alignment',
                    'Border styling',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property handles overflow in Row?',
                  'options': [
                    'overflow',
                    'textOverflow',
                    'clipBehavior',
                    'No property needed',
                  ],
                  'correctAnswerIndex': 2,
                },
                {
                  'question': 'What happens with unbounded Row width?',
                  'options': [
                    'Throws layout error',
                    'Takes minimum space',
                    'Takes maximum space',
                    'Becomes scrollable',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Column',
              'description':
                  'A widget that displays its children in a vertical array.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/Column-class.html',
              'quizQuestions': [
                {
                  'question': 'What is the primary purpose of Column widget?',
                  'options': [
                    'Arrange children vertically',
                    'Manage app state',
                    'Handle navigation',
                    'Manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property controls vertical alignment?',
                  'options': [
                    'mainAxisAlignment',
                    'crossAxisAlignment',
                    'direction',
                    'alignment',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Column have unlimited children?',
                  'options': [
                    'Yes, but performance may suffer',
                    'No, limited to 10',
                    'No, limited to 5',
                    'Depends on device',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does Column mainAxisSize property control?',
                  'options': [
                    'How much space Column takes',
                    'Child widget size',
                    'Text size',
                    'Border thickness',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'Which widget is Column\'s horizontal counterpart?',
                  'options': ['Row', 'List', 'Stack', 'Grid'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What happens with Column flexible children?',
                  'options': [
                    'They share available space',
                    'They become invisible',
                    'They stack horizontally',
                    'They scroll automatically',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Column contain other Columns?',
                  'options': [
                    'Yes, nested layouts possible',
                    'No, only simple widgets',
                    'Only in web apps',
                    'Only with special setup',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Column crossAxisAlignment for?',
                  'options': [
                    'Horizontal alignment of children',
                    'Vertical alignment',
                    'Text alignment',
                    'Border styling',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property handles overflow in Column?',
                  'options': [
                    'overflow',
                    'textOverflow',
                    'clipBehavior',
                    'No property needed',
                  ],
                  'correctAnswerIndex': 2,
                },
                {
                  'question': 'What happens with unbounded Column height?',
                  'options': [
                    'Throws layout error',
                    'Takes minimum space',
                    'Takes maximum space',
                    'Becomes scrollable',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'ListView',
              'description': 'A scrollable list of widgets arranged linearly.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/ListView-class.html',
              'quizQuestions': [
                {
                  'question': 'What is the primary purpose of ListView?',
                  'options': [
                    'Create scrollable list of items',
                    'Manage app state',
                    'Handle navigation',
                    'Manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property controls scroll direction?',
                  'options': [
                    'scrollDirection',
                    'axis',
                    'direction',
                    'orientation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can ListView have different item types?',
                  'options': [
                    'Yes, with itemBuilder',
                    'No, only same widgets',
                    'Only in web apps',
                    'Only with special setup',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does ListView shrinkWrap property do?',
                  'options': [
                    'Makes ListView size to its content',
                    'Reduces font size',
                    'Hides ListView',
                    'Makes ListView invisible',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'Which widget is ListView\'s single child version?',
                  'options': [
                    'SingleChildScrollView',
                    'ScrollView',
                    'List',
                    'Grid',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What happens with ListView physics property?',
                  'options': [
                    'Controls scrolling behavior',
                    'Changes text color',
                    'Adds animations',
                    'Manages database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can ListView contain other ListViews?',
                  'options': [
                    'Yes, but needs special handling',
                    'No, not allowed',
                    'Only in web apps',
                    'Only with special setup',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is ListView separatorBuilder for?',
                  'options': [
                    'Add separators between items',
                    'Sort list items',
                    'Filter list items',
                    'Group list items',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property handles ListView performance?',
                  'options': [
                    'itemExtent',
                    'performanceMode',
                    'optimization',
                    'No property needed',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What happens with empty ListView?',
                  'options': [
                    'Shows empty state',
                    'Throws error',
                    'Becomes invisible',
                    'Crashes app',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Scaffold',
              'description':
                  'Implements the basic material design visual layout structure.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/material/Scaffold-class.html',
              'quizQuestions': [
                {
                  'question': 'What is the primary purpose of Scaffold?',
                  'options': [
                    'Provide basic material design layout',
                    'Manage app state',
                    'Handle navigation',
                    'Manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property adds app bar to Scaffold?',
                  'options': ['appBar', 'header', 'topBar', 'navigationBar'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Scaffold have floating action button?',
                  'options': [
                    'Yes, using floatingActionButton',
                    'No, not supported',
                    'Only in web apps',
                    'Only with special setup',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does Scaffold body property contain?',
                  'options': [
                    'Main content of the screen',
                    'App configuration',
                    'Database connections',
                    'Network requests',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget is commonly used with Scaffold?',
                  'options': [
                    'MaterialApp',
                    'Container',
                    'Row',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is Scaffold bottomNavigationBar for?',
                  'options': [
                    'Add bottom navigation',
                    'Add footer text',
                    'Control scrolling',
                    'Manage themes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Can Scaffold have drawer?',
                  'options': [
                    'Yes, using drawer property',
                    'No, not supported',
                    'Only in web apps',
                    'Only with special setup',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Scaffold floatingActionButtonLocation?',
                  'options': [
                    'Position FAB on screen',
                    'Animate FAB',
                    'Size FAB',
                    'Style FAB',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property handles Scaffold background?',
                  'options': [
                    'backgroundColor',
                    'background',
                    'color',
                    'theme',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'What happens with Scaffold persistentFooterButtons?',
                  'options': [
                    'Add buttons that stay visible',
                    'Add temporary buttons',
                    'Hide all buttons',
                    'Remove navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
          ],
          'quizQuestions': [
            {
              'question': 'What is a Widget in Flutter?',
              'options': [
                'A database component',
                'A UI building block',
                'A network protocol',
                'A testing framework',
              ],
              'correctAnswerIndex': 1,
            },
            {
              'question': 'Which widget is used for layout?',
              'options': ['Text', 'Container', 'Icon', 'All of the above'],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'What is the purpose of MaterialApp?',
              'options': [
                'To create a material design app',
                'To manage app state',
                'To handle navigation',
                'To manage themes',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget is used for scrolling?',
              'options': ['Row', 'Column', 'ListView', 'Stack'],
              'correctAnswerIndex': 2,
            },
            {
              'question':
                  'What is the difference between StatelessWidget and StatefulWidget?',
              'options': [
                'StatelessWidget has no UI',
                'StatefulWidget can change its appearance',
                'StatelessWidget is faster',
                'Both B and C',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'What is the purpose of Scaffold?',
              'options': [
                'To provide basic material design visual layout structure',
                'To manage app themes',
                'To handle API calls',
                'To manage user authentication',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget is used to display images?',
              'options': ['Image', 'Icon', 'AssetImage', 'All of the above'],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the use of Expanded widget?',
              'options': [
                'To expand a child to fill available space',
                'To increase font size',
                'To add padding',
                'To add margin',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget is used for user input?',
              'options': ['Text', 'TextField', 'RichText', 'TextSpan'],
              'correctAnswerIndex': 1,
            },
            {
              'question': 'What is the purpose of AppBar?',
              'options': [
                'To display app title and actions',
                'To manage app state',
                'To handle navigation',
                'To manage themes',
              ],
              'correctAnswerIndex': 0,
            },
          ],
        },
        {
          'name': 'State Management',
          'description':
              'Understand how to manage state in Flutter applications. State management is how you organize and manage the data that changes in your application.',
          'tutorialLink':
              'https://flutter.dev/docs/development/data-and-backend/state-mgmt',
          'subtopics': [
            {
              'name': 'Provider',
              'description':
                  'A recommended state management solution for Flutter apps that uses InheritedWidget under the hood.',
              'tutorialLink':
                  'https://pub.dev/documentation/provider/latest/provider/Provider-class.html',
              'quizQuestions': [
                {
                  'question': 'What is Provider in Flutter?',
                  'options': [
                    'A state management solution',
                    'A UI widget',
                    'A database library',
                    'A networking library',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget listens to Provider changes?',
                  'options': [
                    'Consumer',
                    'Builder',
                    'Provider',
                    'InheritedWidget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you provide data with Provider?',
                  'options': [
                    'Using ChangeNotifierProvider',
                    'Using StatefulWidget',
                    'Using setState',
                    'Using FutureBuilder',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does ChangeNotifier do?',
                  'options': [
                    'Notifies listeners of changes',
                    'Creates UI widgets',
                    'Manages database',
                    'Handles navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method notifies listeners?',
                  'options': [
                    'notifyListeners()',
                    'setState()',
                    'build()',
                    'initState()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of Provider?',
                  'options': [
                    'Reduces boilerplate code',
                    'Improves performance',
                    'Simplifies rebuilding',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you access provided data?',
                  'options': [
                    'Using context.read<T>()',
                    'Using context.watch<T>()',
                    'Using Provider.of<T>(context)',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is MultiProvider used for?',
                  'options': [
                    'Provide multiple values',
                    'Create multiple widgets',
                    'Manage multiple states',
                    'Handle multiple routes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget rebuilds on data changes?',
                  'options': [
                    'Consumer',
                    'Provider',
                    'Builder',
                    'StatefulWidget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of context.watch?',
                  'options': [
                    'Listen to data changes',
                    'Read data once',
                    'Modify data',
                    'Create widgets',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Riverpod',
              'description':
                  'A modern state management solution that is a complete rewrite of Provider with compile-time safety.',
              'tutorialLink':
                  'https://riverpod.dev/docs/introduction/getting_started',
              'quizQuestions': [
                {
                  'question': 'What is Riverpod?',
                  'options': [
                    'A state management solution',
                    'A UI framework',
                    'A database library',
                    'A testing framework',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the main advantage of Riverpod?',
                  'options': [
                    'Compile-time safety',
                    'Better performance',
                    'Simpler syntax',
                    'Built-in animations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you define a provider in Riverpod?',
                  'options': [
                    'Using Provider()',
                    'Using StateProvider()',
                    'Using FutureProvider()',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which widget consumes Riverpod providers?',
                  'options': [
                    'ConsumerWidget',
                    'ProviderListener',
                    'RiverpodConsumer',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is StateProvider used for?',
                  'options': [
                    'Managing mutable state',
                    'Creating immutable data',
                    'Handling async data',
                    'Managing routes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you read a provider without listening?',
                  'options': [
                    'ref.read(provider)',
                    'ref.watch(provider)',
                    'ref.listen(provider)',
                    'Provider.of(context)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is FutureProvider used for?',
                  'options': [
                    'Handling async data',
                    'Managing mutable state',
                    'Creating UI widgets',
                    'Handling navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does ref.listen do?',
                  'options': [
                    'Listen to provider changes',
                    'Read provider value',
                    'Modify provider value',
                    'Create providers',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which is NOT a Riverpod provider?',
                  'options': [
                    'StateProvider',
                    'FutureProvider',
                    'StreamProvider',
                    'WidgetProvider',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is the purpose of ProviderScope?',
                  'options': [
                    'Root of Riverpod app',
                    'UI widget container',
                    'Database connection',
                    'Network manager',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Bloc',
              'description':
                  'A state management pattern that helps implement the BLoC (Business Logic Component) design pattern.',
              'tutorialLink': 'https://bloclibrary.dev/#/gettingstarted',
              'quizQuestions': [
                {
                  'question': 'What does BLoC stand for?',
                  'options': [
                    'Business Logic Component',
                    'Backend Logic Controller',
                    'Basic Layout Component',
                    'Browser Logic Container',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which stream does Bloc use?',
                  'options': [
                    'Stream<State>',
                    'Future<State>',
                    'List<State>',
                    'Map<State>',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What method handles events in Bloc?',
                  'options': [
                    'mapEventToState',
                    'handleEvent',
                    'processEvent',
                    'onEvent',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget consumes Bloc state?',
                  'options': [
                    'BlocBuilder',
                    'BlocListener',
                    'BlocConsumer',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is the purpose of BlocListener?',
                  'options': [
                    'Handle side effects',
                    'Build UI',
                    'Manage state',
                    'Handle navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you add events to Bloc?',
                  'options': [
                    'bloc.add(event)',
                    'bloc.emit(event)',
                    'bloc.send(event)',
                    'bloc.post(event)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Equatable used for?',
                  'options': [
                    'Optimize rebuilds',
                    'Create UI',
                    'Handle navigation',
                    'Manage database',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package provides Bloc?',
                  'options': [
                    'flutter_bloc',
                    'provider',
                    'riverpod',
                    'state_management',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of emit() in Bloc?',
                  'options': [
                    'Emit new states',
                    'Add events',
                    'Create widgets',
                    'Handle navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is BlocConsumer?',
                  'options': [
                    'Combines BlocBuilder and BlocListener',
                    'Manages multiple Blocs',
                    'Handles async data',
                    'Creates UI widgets',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'GetX',
              'description':
                  'A lightweight state management, navigation, and dependency injection solution for Flutter.',
              'tutorialLink': 'https://pub.dev/packages/get',
              'quizQuestions': [
                {
                  'question': 'What is GetX?',
                  'options': [
                    'State management solution',
                    'Navigation solution',
                    'Dependency injection',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you create a reactive variable?',
                  'options': [
                    'Using .obs',
                    'Using setState',
                    'Using Provider',
                    'Using Future',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget rebuilds on GetX changes?',
                  'options': ['Obx', 'GetX', 'Observer', 'ReactiveWidget'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you navigate with GetX?',
                  'options': [
                    'Get.to()',
                    'Navigator.push()',
                    'Route.to()',
                    'Navigation.push()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Get.put() used for?',
                  'options': [
                    'Dependency injection',
                    'State management',
                    'Navigation',
                    'UI building',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you bind controllers in GetX?',
                  'options': [
                    'Using Get.put()',
                    'Using Provider',
                    'Using StatefulWidget',
                    'Using FutureBuilder',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of Get.find()?',
                  'options': [
                    'Retrieve injected dependencies',
                    'Find UI widgets',
                    'Navigate to screens',
                    'Manage state',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which is a GetX controller?',
                  'options': [
                    'GetxController',
                    'StatefulWidget',
                    'Provider',
                    'Bloc',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you close GetX controllers?',
                  'options': [
                    'Override onClose()',
                    'Using dispose()',
                    'Using setState()',
                    'Using remove()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is GetBuilder used for?',
                  'options': [
                    'Manual state updates',
                    'Automatic rebuilds',
                    'Navigation',
                    'Dependency injection',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'setState',
              'description':
                  'The simplest form of state management in Flutter using StatefulWidget and setState method.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/State/setState.html',
              'quizQuestions': [
                {
                  'question': 'When should you use setState?',
                  'options': [
                    'For simple local state',
                    'For complex app state',
                    'For global state',
                    'For persistent state',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget uses setState?',
                  'options': [
                    'StatefulWidget',
                    'StatelessWidget',
                    'InheritedWidget',
                    'ProxyWidget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does setState do?',
                  'options': [
                    'Schedule a rebuild',
                    'Change widget properties',
                    'Update database',
                    'Navigate to screen',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Where should setState be called?',
                  'options': [
                    'Inside State class',
                    'Inside Widget class',
                    'Anywhere in app',
                    'Only in build method',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What parameter does setState take?',
                  'options': ['VoidCallback', 'Function', 'Future', 'Stream'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the cost of setState?',
                  'options': [
                    'Rebuilds entire widget',
                    'No performance cost',
                    'Only rebuilds children',
                    'Only rebuilds parent',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How often should you call setState?',
                  'options': [
                    'Only when needed',
                    'Every frame',
                    'Every second',
                    'Only once',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What should you avoid in setState?',
                  'options': [
                    'Heavy computations',
                    'Simple assignments',
                    'UI updates',
                    'State changes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'What happens if setState is called after dispose?',
                  'options': [
                    'Throws exception',
                    'Nothing happens',
                    'Widget rebuilds',
                    'App crashes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which lifecycle method is related to setState?',
                  'options': ['mounted', 'initState', 'dispose', 'build'],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'InheritedWidget',
              'description':
                  'A base class for widgets that efficiently propagate information down the widget tree.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html',
              'quizQuestions': [
                {
                  'question': 'What is InheritedWidget used for?',
                  'options': [
                    'Share data down tree',
                    'Manage state',
                    'Handle navigation',
                    'Create animations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method provides data?',
                  'options': [
                    'of() method',
                    'get() method',
                    'find() method',
                    'read() method',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do children access InheritedWidget?',
                  'options': [
                    'Using context.dependOnInheritedWidgetOfExactType',
                    'Using context.findAncestorWidgetOfExactType',
                    'Both A and B',
                    'Neither A nor B',
                  ],
                  'correctAnswerIndex': 2,
                },
                {
                  'question': 'When does InheritedWidget rebuild?',
                  'options': [
                    'When updateShouldNotify returns true',
                    'Every frame',
                    'When parent rebuilds',
                    'Never rebuilds',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does updateShouldNotify do?',
                  'options': [
                    'Control rebuilds',
                    'Update data',
                    'Navigate screens',
                    'Manage state',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which is built on InheritedWidget?',
                  'options': [
                    'Provider',
                    'StatefulWidget',
                    'StatelessWidget',
                    'ProxyWidget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of InheritedWidget?',
                  'options': [
                    'Efficient data sharing',
                    'Better performance',
                    'Reduced boilerplate',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you create InheritedWidget?',
                  'options': [
                    'Extend InheritedWidget',
                    'Use StatefulWidget',
                    'Use StatelessWidget',
                    'Use ProxyWidget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the return type of of() method?',
                  'options': [
                    'InheritedWidget subtype',
                    'Widget',
                    'BuildContext',
                    'void',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method gets widget without subscribing?',
                  'options': [
                    'findAncestorWidgetOfExactType',
                    'dependOnInheritedWidgetOfExactType',
                    'ancestorWidgetOfExactType',
                    'getInheritedWidgetOfExactType',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
          ],
          'quizQuestions': [
            {
              'question': 'What is state in Flutter?',
              'options': [
                'Application data that changes',
                'UI configuration',
                'Database records',
                'Network responses',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which is a state management approach?',
              'options': ['setState', 'Provider', 'Bloc', 'All of the above'],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'When should you use StatefulWidget?',
              'options': [
                'When UI needs to change',
                'For static content',
                'For performance',
                'Always',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the purpose of setState?',
              'options': [
                'To rebuild the widget',
                'To manage app themes',
                'To handle navigation',
                'To manage database',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question':
                  'Which package is commonly used for state management?',
              'options': ['http', 'provider', 'shared_preferences', 'sqflite'],
              'correctAnswerIndex': 1,
            },
            {
              'question': 'What is InheritedWidget used for?',
              'options': [
                'Sharing data down the widget tree',
                'Managing database connections',
                'Handling network requests',
                'Managing themes',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the benefit of Provider?',
              'options': [
                'Reduces boilerplate code',
                'Improves performance',
                'Simplifies widget rebuilding',
                'All of the above',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question':
                  'What is the difference between ephemeral and app state?',
              'options': [
                'Ephemeral is temporary, app state is persistent',
                'Ephemeral is for UI, app state is for data',
                'There is no difference',
                'Both A and B',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'Which widget listens to changes in Provider?',
              'options': [
                'Consumer',
                'Builder',
                'LayoutBuilder',
                'ValueListenableBuilder',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is ChangeNotifier?',
              'options': [
                'A class that can be extended to create observable objects',
                'A widget for notifications',
                'A database change listener',
                'A network status monitor',
              ],
              'correctAnswerIndex': 0,
            },
          ],
        },
        {
          'name': 'Navigation',
          'description':
              'Learn how to navigate between screens in Flutter. Navigation is the act of moving from one screen to another in your application.',
          'tutorialLink': 'https://flutter.dev/docs/development/ui/navigation',
          'subtopics': [
            {
              'name': 'Basic Navigation',
              'description':
                  'Learn the fundamentals of navigating between screens using Navigator and MaterialPageRoute.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/ui/navigation#example',
              'quizQuestions': [
                {
                  'question': 'Which widget is used for navigation?',
                  'options': [
                    'Navigator',
                    'Router',
                    'PageRoute',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is MaterialPageRoute?',
                  'options': [
                    'A route that uses material design transitions',
                    'A database route',
                    'A network route',
                    'A testing route',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you navigate to a new screen?',
                  'options': [
                    'Navigator.push()',
                    'Navigator.pop()',
                    'Navigator.replace()',
                    'Navigator.remove()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you go back to previous screen?',
                  'options': [
                    'Navigator.push()',
                    'Navigator.pop()',
                    'Navigator.replace()',
                    'Navigator.remove()',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question': 'What is the purpose of Navigator.push()?',
                  'options': [
                    'Add route to stack',
                    'Remove route from stack',
                    'Replace current route',
                    'Clear all routes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method removes current route?',
                  'options': [
                    'Navigator.push()',
                    'Navigator.pop()',
                    'Navigator.replace()',
                    'Navigator.clear()',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question': 'What does Navigator.of(context) return?',
                  'options': [
                    'Closest Navigator instance',
                    'New Navigator instance',
                    'Root Navigator',
                    'Null',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you push named route?',
                  'options': [
                    'Navigator.pushNamed()',
                    'Navigator.push()',
                    'Navigator.pushRoute()',
                    'Navigator.pushNamedRoute()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the return type of Navigator.push()?',
                  'options': ['Future<T>', 'void', 'Widget', 'BuildContext'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which parameter passes data to new screen?',
                  'options': ['arguments', 'data', 'params', 'extras'],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Named Routes',
              'description':
                  'Use named routes for cleaner and more maintainable navigation in your Flutter app.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/ui/navigation#using-named-routes',
              'quizQuestions': [
                {
                  'question': 'What is named routing?',
                  'options': [
                    'Using string names to identify routes',
                    'Using numbers for routes',
                    'Using widgets for routes',
                    'Using functions for routes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property defines named routes?',
                  'options': ['routes', 'pages', 'screens', 'navigators'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Where do you define named routes?',
                  'options': [
                    'MaterialApp widget',
                    'Scaffold widget',
                    'Navigator widget',
                    'AppBar widget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you navigate to named route?',
                  'options': [
                    'Navigator.pushNamed()',
                    'Navigator.push()',
                    'Navigator.goTo()',
                    'Navigator.navigate()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of named routes?',
                  'options': [
                    'Cleaner code',
                    'Better organization',
                    'Easier maintenance',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which widget handles route generation?',
                  'options': [
                    'onGenerateRoute',
                    'onUnknownRoute',
                    'initialRoute',
                    'navigatorKey',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is initialRoute property?',
                  'options': [
                    'First route to load',
                    'Last route to load',
                    'Error route',
                    'Default route',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you pass arguments to named routes?',
                  'options': [
                    'Navigator.pushNamed(arguments: data)',
                    'Navigator.pushNamed(data: data)',
                    'Navigator.pushNamed(params: data)',
                    'Navigator.pushNamed(extras: data)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method handles unknown routes?',
                  'options': [
                    'onUnknownRoute',
                    'onGenerateRoute',
                    'onErrorRoute',
                    'onNotFoundRoute',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does onGenerateRoute return?',
                  'options': ['Route<T>', 'Widget', 'Future<T>', 'void'],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Go Router',
              'description':
                  'A declarative routing package for Flutter that simplifies navigation with a single config.',
              'tutorialLink': 'https://pub.dev/packages/go_router',
              'quizQuestions': [
                {
                  'question': 'What is Go Router?',
                  'options': [
                    'Declarative routing package',
                    'UI widget',
                    'State management solution',
                    'Database library',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package provides Go Router?',
                  'options': [
                    'go_router',
                    'flutter_router',
                    'navigation',
                    'routes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the main benefit of Go Router?',
                  'options': [
                    'Declarative routing',
                    'Better performance',
                    'Simpler syntax',
                    'Built-in animations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you define routes in Go Router?',
                  'options': [
                    'Using GoRoute objects',
                    'Using String paths',
                    'Using Widget routes',
                    'Using Function routes',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget is the root of Go Router?',
                  'options': [
                    'GoRouter',
                    'MaterialApp.router',
                    'Navigator',
                    'Router',
                  ],
                  'correctAnswerIndex': 1,
                },
                {
                  'question': 'How do you navigate with Go Router?',
                  'options': [
                    'context.go()',
                    'Navigator.push()',
                    'Router.navigate()',
                    'GoRouter.push()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is path parameter in GoRoute?',
                  'options': [
                    'URL path pattern',
                    'Widget path',
                    'Data path',
                    'Route path',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you access path parameters?',
                  'options': [
                    'GoRouterState.of(context).params',
                    'context.params',
                    'Route.of(context).params',
                    'Navigator.of(context).params',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of redirect in GoRoute?',
                  'options': [
                    'Redirect to different route',
                    'Reload current route',
                    'Remove route from stack',
                    'Replace route',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method handles deep linking?',
                  'options': [
                    'Go Router supports it',
                    'Navigator.pushNamed()',
                    'MaterialApp.routes',
                    'onGenerateRoute',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Bottom Navigation',
              'description':
                  'Implement bottom navigation bars for tab-based navigation in your Flutter app.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html',
              'quizQuestions': [
                {
                  'question': 'Which widget creates bottom navigation?',
                  'options': [
                    'BottomNavigationBar',
                    'TabBar',
                    'NavigationBar',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What property controls selected index?',
                  'options': [
                    'currentIndex',
                    'selectedIndex',
                    'activeIndex',
                    'focusedIndex',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which callback handles tab changes?',
                  'options': ['onTap', 'onChange', 'onSelect', 'onPressed'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is BottomNavigationBarType?',
                  'options': [
                    'Fixed and Shifting',
                    'Static and Dynamic',
                    'Fixed and Flexible',
                    'Standard and Adaptive',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property sets tab items?',
                  'options': ['items', 'tabs', 'children', 'pages'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does fixed type do?',
                  'options': [
                    'All tabs same color',
                    'Tabs change color',
                    'Tabs animate',
                    'Tabs scroll',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does shifting type do?',
                  'options': [
                    'Active tab changes color',
                    'All tabs same color',
                    'Tabs don\'t animate',
                    'Tabs don\'t scroll',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget works with BottomNavigationBar?',
                  'options': ['Scaffold', 'MaterialApp', 'Navigator', 'AppBar'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you set active color?',
                  'options': [
                    'fixedColor',
                    'activeColor',
                    'selectedColor',
                    'primaryColor',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of BottomNavigationBar?',
                  'options': [
                    'Bottom tab navigation',
                    'Top tab navigation',
                    'Side navigation',
                    'Drawer navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Drawer Navigation',
              'description':
                  'Create side navigation drawers for menu-based navigation in your Flutter app.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/material/Drawer-class.html',
              'quizQuestions': [
                {
                  'question': 'Which widget creates side drawer?',
                  'options': [
                    'Drawer',
                    'SideDrawer',
                    'NavigationDrawer',
                    'MenuDrawer',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Where do you place Drawer widget?',
                  'options': [
                    'Scaffold.drawer',
                    'MaterialApp.drawer',
                    'Navigator.drawer',
                    'AppBar.drawer',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method opens drawer programmatically?',
                  'options': [
                    'Scaffold.of(context).openDrawer()',
                    'Navigator.of(context).openDrawer()',
                    'Drawer.of(context).open()',
                    'MaterialApp.of(context).openDrawer()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the main content of Drawer?',
                  'options': ['ListView', 'Column', 'Row', 'Stack'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget creates drawer header?',
                  'options': [
                    'DrawerHeader',
                    'Header',
                    'AppBar',
                    'UserAccountsDrawerHeader',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you close drawer?',
                  'options': [
                    'Navigator.pop()',
                    'Scaffold.of(context).closeDrawer()',
                    'Drawer.of(context).close()',
                    'MaterialApp.of(context).closeDrawer()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is UserAccountsDrawerHeader?',
                  'options': [
                    'Special drawer header for accounts',
                    'Standard drawer header',
                    'Custom drawer header',
                    'Animated drawer header',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property sets drawer width?',
                  'options': ['width', 'drawerWidth', 'size', 'Cannot be set'],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you set drawer edge drag width?',
                  'options': [
                    'drawerEdgeDragWidth',
                    'dragWidth',
                    'edgeWidth',
                    'swipeWidth',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of Drawer?',
                  'options': [
                    'Side menu navigation',
                    'Bottom navigation',
                    'Top navigation',
                    'Tab navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Tab Navigation',
              'description':
                  'Implement tab-based navigation using TabBar and TabController for organized content.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/material/TabBar-class.html',
              'quizQuestions': [
                {
                  'question': 'Which widget creates horizontal tabs?',
                  'options': [
                    'TabBar',
                    'BottomNavigationBar',
                    'NavigationBar',
                    'Tabs',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which controller manages tabs?',
                  'options': [
                    'TabController',
                    'PageController',
                    'ScrollController',
                    'AnimationController',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Where do you place TabBar?',
                  'options': [
                    'AppBar.bottom',
                    'Scaffold.body',
                    'MaterialApp.home',
                    'Navigator.tabs',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget displays tab content?',
                  'options': ['TabBarView', 'PageView', 'ListView', 'GridView'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you create TabController?',
                  'options': [
                    'TabController(length: n, vsync: this)',
                    'TabController(n)',
                    'TabController.create(n)',
                    'TabController.new(n)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property sets tab labels?',
                  'options': ['tabs', 'labels', 'items', 'children'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of TabBar?',
                  'options': [
                    'Horizontal tab navigation',
                    'Vertical tab navigation',
                    'Bottom navigation',
                    'Side navigation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you set active tab indicator?',
                  'options': [
                    'indicator',
                    'activeIndicator',
                    'tabIndicator',
                    'selectionIndicator',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget works with TabBar?',
                  'options': ['TabBarView', 'PageView', 'ListView', 'GridView'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does TabController.animateTo do?',
                  'options': [
                    'Animate to specific tab',
                    'Create new tab',
                    'Remove tab',
                    'Resize tab',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
          ],
          'quizQuestions': [
            {
              'question': 'Which widget is used for navigation?',
              'options': [
                'Navigator',
                'Router',
                'PageRoute',
                'All of the above',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is MaterialPageRoute?',
              'options': [
                'A route that uses material design transitions',
                'A database route',
                'A network route',
                'A testing route',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'How do you navigate to a new screen?',
              'options': [
                'Navigator.push()',
                'Navigator.pop()',
                'Navigator.replace()',
                'Navigator.remove()',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'How do you go back to previous screen?',
              'options': [
                'Navigator.push()',
                'Navigator.pop()',
                'Navigator.replace()',
                'Navigator.remove()',
              ],
              'correctAnswerIndex': 1,
            },
            {
              'question': 'What is named routing?',
              'options': [
                'Using string names to identify routes',
                'Using numbers for routes',
                'Using widgets for routes',
                'Using functions for routes',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which property defines named routes?',
              'options': ['routes', 'pages', 'screens', 'navigators'],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the purpose of onGenerateRoute?',
              'options': [
                'To generate routes dynamically',
                'To create widgets',
                'To manage state',
                'To handle errors',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'How do you pass data to a new screen?',
              'options': [
                'Through constructor parameters',
                'Through global variables',
                'Through shared preferences',
                'Through database',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the return type of Navigator.push()?',
              'options': ['Future<T>', 'void', 'Widget', 'BuildContext'],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the purpose of Navigator.pop()?',
              'options': [
                'To remove current route from stack',
                'To add a new route',
                'To replace current route',
                'To refresh current route',
              ],
              'correctAnswerIndex': 0,
            },
          ],
        },
        {
          'name': 'Animations',
          'description':
              'Create beautiful animations in Flutter. Animations make your app more engaging and provide visual feedback to users.',
          'tutorialLink': 'https://flutter.dev/docs/development/ui/animations',
          'subtopics': [
            {
              'name': 'Implicit Animations',
              'description':
                  'Learn how to create simple animations using built-in implicit animation widgets.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/ui/animations/implicit-animations',
              'quizQuestions': [
                {
                  'question': 'What are implicit animations?',
                  'options': [
                    'Animations with built-in controllers',
                    'Animations with manual controllers',
                    'Complex animations',
                    'Custom animations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates opacity?',
                  'options': [
                    'AnimatedOpacity',
                    'Opacity',
                    'FadeTransition',
                    'AnimatedFade',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates container properties?',
                  'options': [
                    'AnimatedContainer',
                    'Container',
                    'AnimatedWidget',
                    'AnimatedBuilder',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates position?',
                  'options': [
                    'AnimatedPositioned',
                    'Positioned',
                    'AnimatedAlign',
                    'AnimatedPosition',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What property controls animation duration?',
                  'options': ['duration', 'curve', 'delay', 'speed'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates alignment?',
                  'options': [
                    'AnimatedAlign',
                    'Align',
                    'AnimatedPositioned',
                    'AnimatedContainer',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What property controls animation curve?',
                  'options': ['curve', 'duration', 'delay', 'speed'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates padding?',
                  'options': [
                    'AnimatedPadding',
                    'Padding',
                    'AnimatedContainer',
                    'AnimatedWidget',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of implicit animations?',
                  'options': [
                    'Simplicity',
                    'Performance',
                    'Flexibility',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates default text style?',
                  'options': [
                    'AnimatedDefaultTextStyle',
                    'DefaultTextStyle',
                    'AnimatedText',
                    'AnimatedStyle',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Explicit Animations',
              'description':
                  'Create custom animations with manual control using AnimationController and Tween.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/ui/animations/tutorial',
              'quizQuestions': [
                {
                  'question': 'What is AnimationController?',
                  'options': [
                    'Controls animation state',
                    'Creates animation widgets',
                    'Manages animation data',
                    'Handles animation events',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which class interpolates values?',
                  'options': [
                    'Tween',
                    'Animation',
                    'Controller',
                    'Interpolator',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'Which mixin is required for AnimationController?',
                  'options': [
                    'TickerProviderStateMixin',
                    'AnimationMixin',
                    'ControllerMixin',
                    'TickerMixin',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you start animation?',
                  'options': ['forward()', 'start()', 'play()', 'run()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you reverse animation?',
                  'options': ['reverse()', 'backward()', 'rewind()', 'stop()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget rebuilds on animation changes?',
                  'options': [
                    'AnimatedBuilder',
                    'Animation',
                    'AnimatedWidget',
                    'Both A and C',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What is the purpose of vsync parameter?',
                  'options': [
                    'Prevent tearing',
                    'Improve performance',
                    'Reduce battery usage',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which property sets animation duration?',
                  'options': ['duration', 'curve', 'delay', 'speed'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you dispose AnimationController?',
                  'options': [
                    'controller.dispose()',
                    'controller.stop()',
                    'controller.cancel()',
                    'controller.close()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is AnimatedWidget?',
                  'options': [
                    'Base class for animated widgets',
                    'Animation controller',
                    'Tween class',
                    'Curve class',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Animation Widgets',
              'description':
                  'Explore various animation widgets for different visual effects and transitions.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/animation-library.html',
              'quizQuestions': [
                {
                  'question': 'Which widget fades in/out a child?',
                  'options': [
                    'FadeTransition',
                    'Opacity',
                    'AnimatedOpacity',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget rotates a child?',
                  'options': [
                    'RotationTransition',
                    'Transform',
                    'RotatedBox',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget scales a child?',
                  'options': [
                    'ScaleTransition',
                    'Transform',
                    'AnimatedContainer',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget slides a child?',
                  'options': [
                    'SlideTransition',
                    'PositionedTransition',
                    'AnimatedPositioned',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates size?',
                  'options': [
                    'SizeTransition',
                    'AnimatedContainer',
                    'AnimatedSize',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates alignment?',
                  'options': [
                    'AlignTransition',
                    'AnimatedAlign',
                    'AlignmentTransition',
                    'AnimatedAlignment',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates relative rect?',
                  'options': [
                    'RelativeRectTransition',
                    'AnimatedPositioned',
                    'PositionedTransition',
                    'RectTransition',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget decorates with animated border?',
                  'options': [
                    'DecoratedBoxTransition',
                    'AnimatedContainer',
                    'BoxDecorationTransition',
                    'AnimatedDecoration',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates default text style?',
                  'options': [
                    'DefaultTextStyleTransition',
                    'AnimatedDefaultTextStyle',
                    'TextStyleTransition',
                    'AnimatedTextStyle',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget animates physical model?',
                  'options': [
                    'PhysicalModelTransition',
                    'AnimatedPhysicalModel',
                    'ModelTransition',
                    'AnimatedModel',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Curves and Easing',
              'description':
                  'Apply curves and easing functions to create natural and expressive animations.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/animation/Curves-class.html',
              'quizQuestions': [
                {
                  'question': 'What is the purpose of Curves?',
                  'options': [
                    'Apply easing to animations',
                    'Create curves',
                    'Manage state',
                    'Handle gestures',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which curve creates a bouncing effect?',
                  'options': [
                    'Curves.bounceOut',
                    'Curves.linear',
                    'Curves.easeIn',
                    'Curves.decelerate',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which curve provides linear animation?',
                  'options': [
                    'Curves.linear',
                    'Curves.easeIn',
                    'Curves.easeOut',
                    'Curves.easeInOut',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which curve starts slow and ends fast?',
                  'options': [
                    'Curves.easeIn',
                    'Curves.easeOut',
                    'Curves.easeInOut',
                    'Curves.linear',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which curve starts fast and ends slow?',
                  'options': [
                    'Curves.easeOut',
                    'Curves.easeIn',
                    'Curves.easeInOut',
                    'Curves.linear',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which curve starts and ends slow?',
                  'options': [
                    'Curves.easeInOut',
                    'Curves.easeIn',
                    'Curves.easeOut',
                    'Curves.linear',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you apply curve to animation?',
                  'options': [
                    'CurvedAnimation',
                    'CurveTween',
                    'AnimationCurve',
                    'Both A and B',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which curve creates elastic effect?',
                  'options': [
                    'Curves.elasticOut',
                    'Curves.bounceOut',
                    'Curves.easeOut',
                    'Curves.linear',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which curve creates overshoot effect?',
                  'options': [
                    'Curves.overshoot',
                    'Curves.bounceOut',
                    'Curves.elasticOut',
                    'Curves.easeOut',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Interval used for?',
                  'options': [
                    'Delay animation portion',
                    'Speed up animation',
                    'Slow down animation',
                    'Stop animation',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Physics-based Animations',
              'description':
                  'Create realistic animations using physics simulation like springs and gravity.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/ui/animations/physics-simulations',
              'quizQuestions': [
                {
                  'question': 'Which simulation models spring physics?',
                  'options': [
                    'SpringSimulation',
                    'GravitySimulation',
                    'FrictionSimulation',
                    'BouncingSimulation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which simulation models gravity?',
                  'options': [
                    'GravitySimulation',
                    'SpringSimulation',
                    'FrictionSimulation',
                    'FallingSimulation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which simulation models friction?',
                  'options': [
                    'FrictionSimulation',
                    'SpringSimulation',
                    'GravitySimulation',
                    'SlidingSimulation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which class drives physics animation?',
                  'options': [
                    'AnimationController',
                    'PhysicsController',
                    'SimulationController',
                    'MotionController',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What parameter controls spring stiffness?',
                  'options': ['stiffness', 'damping', 'mass', 'velocity'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What parameter controls spring damping?',
                  'options': ['damping', 'stiffness', 'mass', 'velocity'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method gets simulation value?',
                  'options': [
                    'x(double time)',
                    'value(double time)',
                    'get(double time)',
                    'position(double time)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method checks if simulation is done?',
                  'options': [
                    'isDone(double time)',
                    'done(double time)',
                    'finished(double time)',
                    'complete(double time)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is Tolerance used for?',
                  'options': [
                    'Define simulation end condition',
                    'Measure performance',
                    'Control speed',
                    'Manage memory',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget uses physics simulation?',
                  'options': [
                    'Scrollable',
                    'AnimatedContainer',
                    'AnimatedWidget',
                    'AnimationBuilder',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Staggered Animations',
              'description':
                  'Create coordinated animations that run in sequence or with delays for complex visual effects.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/ui/animations/staggered-animations',
              'quizQuestions': [
                {
                  'question': 'What are staggered animations?',
                  'options': [
                    'Animations with delays',
                    'Animations that run together',
                    'Simple animations',
                    'Physics animations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which class helps with staggered animations?',
                  'options': ['Interval', 'Stagger', 'Delay', 'Sequence'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you delay animation start?',
                  'options': [
                    'Interval(begin: 0.2, end: 1.0)',
                    'Duration(delay: 200)',
                    'Animation.delay(200)',
                    'Controller.delay(200)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which parameter sets animation start time?',
                  'options': ['begin', 'start', 'delay', 'offset'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which parameter sets animation end time?',
                  'options': ['end', 'finish', 'duration', 'complete'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'How do you create multiple staggered animations?',
                  'options': [
                    'Multiple Interval objects',
                    'Multiple Animation objects',
                    'Multiple Controller objects',
                    'Multiple Tween objects',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of staggered animations?',
                  'options': [
                    'Better visual appeal',
                    'Improved performance',
                    'Simpler code',
                    'Less memory usage',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question':
                      'Which widget is often used with staggered animations?',
                  'options': [
                    'AnimatedBuilder',
                    'AnimatedContainer',
                    'AnimatedWidget',
                    'Animation',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you coordinate multiple animations?',
                  'options': [
                    'Single controller, multiple intervals',
                    'Multiple controllers',
                    'Multiple animations',
                    'Multiple tweens',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the range of Interval values?',
                  'options': [
                    '0.0 to 1.0',
                    '0 to 100',
                    '0 to duration',
                    'Any positive numbers',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
          ],
          'quizQuestions': [
            {
              'question': 'Which class is the base for animations?',
              'options': [
                'Animation',
                'AnimatedWidget',
                'AnimationController',
                'Tween',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is AnimationController?',
              'options': [
                'Controls animation state',
                'Creates animation widgets',
                'Manages animation data',
                'Handles animation events',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question':
                  'Which widget automatically rebuilds on animation changes?',
              'options': [
                'AnimatedBuilder',
                'Animation',
                'AnimatedWidget',
                'Both A and C',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'What is Tween used for?',
              'options': [
                'Interpolating between values',
                'Creating widgets',
                'Managing state',
                'Handling gestures',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which curve creates a bouncing effect?',
              'options': [
                'Curves.linear',
                'Curves.easeIn',
                'Curves.bounceOut',
                'Curves.decelerate',
              ],
              'correctAnswerIndex': 2,
            },
            {
              'question': 'What is the purpose of AnimatedContainer?',
              'options': [
                'Automatically animates property changes',
                'Creates containers',
                'Manages layout',
                'Handles gestures',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget fades in/out a child?',
              'options': [
                'FadeTransition',
                'Opacity',
                'AnimatedOpacity',
                'All of the above',
              ],
              'correctAnswerIndex': 2,
            },
            {
              'question': 'What is the duration property used for?',
              'options': [
                'Setting animation length',
                'Setting widget size',
                'Setting text size',
                'Setting padding',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget rotates a child?',
              'options': [
                'RotationTransition',
                'Transform',
                'RotatedBox',
                'All of the above',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the purpose of CurvedAnimation?',
              'options': [
                'To apply curves to animations',
                'To create curved widgets',
                'To manage curved layouts',
                'To handle curved gestures',
              ],
              'correctAnswerIndex': 0,
            },
          ],
        },
        {
          'name': 'API Integration',
          'description':
              'Learn how to integrate REST APIs in Flutter applications. API integration allows your app to communicate with backend services.',
          'tutorialLink':
              'https://flutter.dev/docs/development/data-and-backend/networking',
          'subtopics': [
            {
              'name': 'HTTP Package',
              'description':
                  'Use the http package to make HTTP requests and handle responses in Flutter apps.',
              'tutorialLink': 'https://pub.dev/packages/http',
              'quizQuestions': [
                {
                  'question':
                      'Which package is commonly used for HTTP requests?',
                  'options': ['http', 'dio', 'chopper', 'All of the above'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you make GET request?',
                  'options': [
                    'http.get()',
                    'http.post()',
                    'http.put()',
                    'http.delete()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you make POST request?',
                  'options': [
                    'http.post()',
                    'http.get()',
                    'http.put()',
                    'http.delete()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the return type of HTTP requests?',
                  'options': [
                    'Future<Response>',
                    'Response',
                    'Future<void>',
                    'void',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you set request headers?',
                  'options': [
                    'headers parameter',
                    'header parameter',
                    'options parameter',
                    'config parameter',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you send JSON data?',
                  'options': [
                    'jsonEncode() and headers',
                    'Direct object',
                    'FormData',
                    'Body parameter',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method parses JSON response?',
                  'options': [
                    'jsonDecode()',
                    'jsonEncode()',
                    'fromJson()',
                    'parseJson()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle errors?',
                  'options': [
                    'try/catch blocks',
                    'if/else statements',
                    'error callbacks',
                    'exception handlers',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of Response object?',
                  'options': [
                    'Contains response data',
                    'Makes requests',
                    'Handles errors',
                    'Manages headers',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property gets response status code?',
                  'options': [
                    'response.statusCode',
                    'response.code',
                    'response.status',
                    'response.errorCode',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Dio Package',
              'description':
                  'A powerful HTTP client with interceptors, global configuration, and more features than the http package.',
              'tutorialLink': 'https://pub.dev/packages/dio',
              'quizQuestions': [
                {
                  'question': 'What is Dio?',
                  'options': [
                    'Powerful HTTP client',
                    'UI widget',
                    'State management',
                    'Database library',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package provides Dio?',
                  'options': ['dio', 'http', 'chopper', 'client'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the main benefit of Dio?',
                  'options': [
                    'Interceptors',
                    'Better performance',
                    'Simpler syntax',
                    'Built-in animations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you create Dio instance?',
                  'options': [
                    'Dio()',
                    'new Dio()',
                    'Dio.create()',
                    'Dio.newInstance()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method makes GET request in Dio?',
                  'options': [
                    'dio.get()',
                    'dio.fetch()',
                    'dio.request()',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'What are interceptors used for?',
                  'options': [
                    'Modify requests/responses',
                    'Handle errors',
                    'Log requests',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you add interceptor?',
                  'options': [
                    'dio.interceptors.add()',
                    'dio.addInterceptor()',
                    'dio.setInterceptor()',
                    'dio.useInterceptor()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which interceptor handles requests?',
                  'options': [
                    'RequestInterceptor',
                    'ResponseInterceptor',
                    'ErrorInterceptor',
                    'LoggingInterceptor',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which interceptor handles responses?',
                  'options': [
                    'ResponseInterceptor',
                    'RequestInterceptor',
                    'ErrorInterceptor',
                    'LoggingInterceptor',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of interceptors?',
                  'options': [
                    'Centralized logic',
                    'Better performance',
                    'Simpler code',
                    'Less memory usage',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'FutureBuilder',
              'description':
                  'Use FutureBuilder to build UI based on the state of a Future, perfect for handling async API responses.',
              'tutorialLink':
                  'https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html',
              'quizQuestions': [
                {
                  'question': 'Which widget handles future data?',
                  'options': [
                    'FutureBuilder',
                    'StreamBuilder',
                    'ValueListenableBuilder',
                    'AnimatedBuilder',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of future parameter?',
                  'options': [
                    'Future to watch',
                    'Data to display',
                    'Error to handle',
                    'Loading state',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which parameter builds UI?',
                  'options': ['builder', 'child', 'widget', 'view'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does ConnectionState.waiting mean?',
                  'options': [
                    'Future is executing',
                    'Future completed',
                    'Future has error',
                    'Future not started',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What does ConnectionState.done mean?',
                  'options': [
                    'Future completed',
                    'Future is executing',
                    'Future has error',
                    'Future not started',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property has snapshot data?',
                  'options': [
                    'snapshot.data',
                    'snapshot.value',
                    'snapshot.result',
                    'snapshot.content',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which property has snapshot error?',
                  'options': [
                    'snapshot.error',
                    'snapshot.exception',
                    'snapshot.failure',
                    'snapshot.message',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle loading state?',
                  'options': [
                    'Check ConnectionState.waiting',
                    'Check snapshot.data',
                    'Check snapshot.error',
                    'Use isLoading property',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle error state?',
                  'options': [
                    'Check snapshot.hasError',
                    'Check snapshot.error',
                    'Check ConnectionState.error',
                    'Use hasError property',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle success state?',
                  'options': [
                    'Check snapshot.hasData',
                    'Check snapshot.data',
                    'Check ConnectionState.done',
                    'Use hasData property',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'JSON Serialization',
              'description':
                  'Convert between JSON and Dart objects for easier API data handling with models and serialization.',
              'tutorialLink':
                  'https://flutter.dev/docs/development/data-and-backend/json',
              'quizQuestions': [
                {
                  'question': 'How do you parse JSON in Flutter?',
                  'options': [
                    'Using jsonDecode()',
                    'Using jsonEncode()',
                    'Using fromJson()',
                    'Both A and C',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you serialize to JSON?',
                  'options': [
                    'Using jsonEncode()',
                    'Using toJson()',
                    'Using jsonDecode()',
                    'Both A and B',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which package helps with JSON serialization?',
                  'options': [
                    'json_serializable',
                    'http',
                    'dio',
                    'built_value',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What annotation generates code?',
                  'options': [
                    '@JsonSerializable()',
                    '@Serializable()',
                    '@Json()',
                    '@Generate()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which part handles JSON keys?',
                  'options': [
                    '@JsonKey()',
                    '@Key()',
                    '@JsonProperty()',
                    '@Field()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you generate serialization code?',
                  'options': [
                    'flutter pub run build_runner build',
                    'flutter pub get',
                    'flutter build',
                    'flutter generate',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of code generation?',
                  'options': [
                    'Type safety',
                    'Better performance',
                    'Less boilerplate',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which method converts object to JSON?',
                  'options': ['toJson()', 'fromJson()', 'toMap()', 'toJSON()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method converts JSON to object?',
                  'options': [
                    'fromJson()',
                    'toJson()',
                    'fromMap()',
                    'fromJSON()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of factory constructor?',
                  'options': [
                    'Create object from JSON',
                    'Create JSON from object',
                    'Initialize fields',
                    'Validate data',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Error Handling',
              'description':
                  'Implement robust error handling for network requests to provide better user experience.',
              'tutorialLink':
                  'https://flutter.dev/docs/cookbook/networking/send-data#handling-errors',
              'quizQuestions': [
                {
                  'question': 'What is the purpose of try/catch?',
                  'options': [
                    'To handle exceptions',
                    'To create animations',
                    'To manage state',
                    'To handle gestures',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which block handles exceptions?',
                  'options': ['catch', 'try', 'finally', 'error'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which block always executes?',
                  'options': ['finally', 'try', 'catch', 'error'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you catch specific exceptions?',
                  'options': [
                    'catch (e) when (condition)',
                    'catch (e, condition)',
                    'catch (condition, e)',
                    'catch when (condition)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method checks network connectivity?',
                  'options': [
                    'connectivity package',
                    'http.get()',
                    'dio.check()',
                    'Network.isConnected()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle timeout errors?',
                  'options': [
                    'Set timeout duration',
                    'Ignore errors',
                    'Retry automatically',
                    'Show default data',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of error handling?',
                  'options': [
                    'Better user experience',
                    'Improved performance',
                    'Simpler code',
                    'Less memory usage',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget shows error messages?',
                  'options': [
                    'SnackBar',
                    'AlertDialog',
                    'Toast',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'How do you retry failed requests?',
                  'options': [
                    'Call method again',
                    'Use cache',
                    'Show error',
                    'Ignore request',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of logging?',
                  'options': [
                    'Debug issues',
                    'Improve performance',
                    'Reduce errors',
                    'Simplify code',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Authentication',
              'description':
                  'Implement authentication flows like JWT tokens, OAuth, and secure storage for user credentials.',
              'tutorialLink': 'https://flutter.dev/docs/development/security',
              'quizQuestions': [
                {
                  'question': 'Which header carries auth token?',
                  'options': [
                    'Authorization',
                    'Authentication',
                    'Token',
                    'Bearer',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is JWT?',
                  'options': [
                    'JSON Web Token',
                    'JavaScript Web Token',
                    'Java Web Token',
                    'JSON Web Toolkit',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you store secure tokens?',
                  'options': [
                    'flutter_secure_storage',
                    'shared_preferences',
                    'sqflite',
                    'hive',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package provides secure storage?',
                  'options': [
                    'flutter_secure_storage',
                    'shared_preferences',
                    'sqflite',
                    'hive',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of secure storage?',
                  'options': [
                    'Encrypted data',
                    'Better performance',
                    'Simpler code',
                    'Less memory usage',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you add auth header?',
                  'options': [
                    'headers[\'Authorization\'] = \'Bearer \$token\'',
                    'headers[\'Token\'] = token',
                    'headers[\'Auth\'] = token',
                    'headers[\'Bearer\'] = token',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which status code means unauthorized?',
                  'options': ['401', '403', '404', '500'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle token expiration?',
                  'options': [
                    'Refresh token',
                    'Logout user',
                    'Ignore error',
                    'Show message',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is OAuth?',
                  'options': [
                    'Open authorization standard',
                    'Object authentication',
                    'Online authentication',
                    'Open authentication',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package helps with OAuth?',
                  'options': [
                    'google_sign_in',
                    'flutter_secure_storage',
                    'shared_preferences',
                    'sqflite',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
          ],
          'quizQuestions': [
            {
              'question': 'Which package is commonly used for HTTP requests?',
              'options': ['http', 'dio', 'chopper', 'All of the above'],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the purpose of async/await?',
              'options': [
                'To handle asynchronous operations',
                'To create animations',
                'To manage state',
                'To handle gestures',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget handles future data?',
              'options': [
                'FutureBuilder',
                'StreamBuilder',
                'ValueListenableBuilder',
                'AnimatedBuilder',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is the return type of HTTP GET request?',
              'options': [
                'Future<Response>',
                'Response',
                'Future<void>',
                'void',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'How do you parse JSON in Flutter?',
              'options': [
                'Using jsonDecode()',
                'Using jsonEncode()',
                'Using fromJson()',
                'Both A and C',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'What is the purpose of try/catch?',
              'options': [
                'To handle exceptions',
                'To create animations',
                'To manage state',
                'To handle gestures',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which method sends POST request?',
              'options': [
                'http.get()',
                'http.post()',
                'http.put()',
                'http.delete()',
              ],
              'correctAnswerIndex': 1,
            },
            {
              'question': 'What is the purpose of headers in HTTP requests?',
              'options': [
                'To send metadata',
                'To encrypt data',
                'To compress data',
                'To cache data',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget handles stream data?',
              'options': [
                'FutureBuilder',
                'StreamBuilder',
                'ValueListenableBuilder',
                'AnimatedBuilder',
              ],
              'correctAnswerIndex': 1,
            },
            {
              'question': 'What is the purpose of Future?',
              'options': [
                'To represent asynchronous computation',
                'To create widgets',
                'To manage state',
                'To handle gestures',
              ],
              'correctAnswerIndex': 0,
            },
          ],
        },
        {
          'name': 'Testing',
          'description':
              'Learn how to test Flutter applications. Testing ensures your app works correctly and helps prevent bugs.',
          'tutorialLink': 'https://flutter.dev/docs/testing',
          'subtopics': [
            {
              'name': 'Widget Tests',
              'description':
                  'Test UI components and their interactions using the flutter_test package and testWidgets function.',
              'tutorialLink':
                  'https://flutter.dev/docs/cookbook/testing/unit/introduction',
              'quizQuestions': [
                {
                  'question': 'What is a widget test?',
                  'options': [
                    'Tests UI components',
                    'Tests business logic',
                    'Tests network requests',
                    'Tests database operations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which function defines a widget test?',
                  'options': [
                    'testWidgets()',
                    'test()',
                    'widgetTest()',
                    'uiTest()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which widget finds widgets by type?',
                  'options': [
                    'find.byType()',
                    'find.byKey()',
                    'find.text()',
                    'find.byIcon()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you tap a widget in tests?',
                  'options': [
                    'tester.tap()',
                    'widget.tap()',
                    'find.tap()',
                    'test.tap()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method waits for animations?',
                  'options': [
                    'tester.pumpAndSettle()',
                    'tester.pump()',
                    'tester.wait()',
                    'tester.animate()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you enter text in tests?',
                  'options': [
                    'tester.enterText()',
                    'tester.typeText()',
                    'tester.inputText()',
                    'tester.fillText()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method renders widget tree?',
                  'options': [
                    'tester.pumpWidget()',
                    'tester.render()',
                    'tester.build()',
                    'tester.show()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you find widget by text?',
                  'options': [
                    'find.text()',
                    'find.byText()',
                    'find.textWidget()',
                    'find.widgetWithText()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which matcher checks widget existence?',
                  'options': [
                    'findsOneWidget',
                    'exists',
                    'isNotNull',
                    'isFound',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you scroll in tests?',
                  'options': [
                    'tester.scrollUntilVisible()',
                    'tester.scrollTo()',
                    'tester.scroll()',
                    'tester.findAndScroll()',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Unit Tests',
              'description':
                  'Test individual functions and classes in isolation to verify business logic correctness.',
              'tutorialLink': 'https://flutter.dev/docs/testing/unit/testing',
              'quizQuestions': [
                {
                  'question': 'What is a unit test?',
                  'options': [
                    'Tests individual functions',
                    'Tests UI components',
                    'Tests network requests',
                    'Tests database operations',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package is used for unit testing?',
                  'options': ['test', 'flutter_test', 'mockito', 'testing'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which function defines a unit test?',
                  'options': [
                    'test()',
                    'testWidgets()',
                    'unitTest()',
                    'assert()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which function groups related tests?',
                  'options': ['group()', 'test()', 'suite()', 'block()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which function asserts test conditions?',
                  'options': ['expect()', 'assert()', 'verify()', 'check()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you test async functions?',
                  'options': [
                    'async/await with Future',
                    'try/catch blocks',
                    'setTimeout',
                    'Promise.then()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which matcher checks equality?',
                  'options': ['equals()', 'equalTo()', 'is()', 'same()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which matcher checks null?',
                  'options': ['isNull', 'isEmpty', 'isNone', 'isNothing'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which matcher checks list length?',
                  'options': ['hasLength()', 'length()', 'size()', 'count()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you test exceptions?',
                  'options': [
                    'throwsA()',
                    'catchError()',
                    'expectError()',
                    'throwsException()',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Integration Tests',
              'description':
                  'Test the entire app flow and user journeys to ensure all components work together correctly.',
              'tutorialLink':
                  'https://flutter.dev/docs/testing/integration-tests',
              'quizQuestions': [
                {
                  'question': 'What is integration testing?',
                  'options': [
                    'Tests the entire app flow',
                    'Tests individual functions',
                    'Tests UI components',
                    'Tests network requests',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package is used for integration tests?',
                  'options': [
                    'integration_test',
                    'flutter_test',
                    'test',
                    'integration',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which function defines integration test?',
                  'options': [
                    'testWidgets()',
                    'test()',
                    'integrationTest()',
                    'appTest()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you run integration tests?',
                  'options': [
                    'flutter drive',
                    'flutter test',
                    'flutter run',
                    'flutter build',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method captures screenshots?',
                  'options': [
                    'takeScreenshot()',
                    'captureScreen()',
                    'screenshot()',
                    'saveScreen()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which class provides app driver?',
                  'options': [
                    'IntegrationTestWidgetsFlutterBinding',
                    'WidgetTester',
                    'TestWidgetsFlutterBinding',
                    'FlutterDriver',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you measure performance?',
                  'options': [
                    'timeline and performance tests',
                    'unit tests',
                    'widget tests',
                    'manual testing',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method traces events?',
                  'options': [
                    'Timeline.startSync()',
                    'Trace.begin()',
                    'Performance.start()',
                    'Monitor.start()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you test on real devices?',
                  'options': [
                    'Connect device and run tests',
                    'Only simulators',
                    'Only emulators',
                    'Cannot test on real devices',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which tool helps with test reporting?',
                  'options': [
                    'flutter test --coverage',
                    'flutter analyze',
                    'flutter doctor',
                    'flutter pub get',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Mockito',
              'description':
                  'Create mock objects for testing dependencies and isolating units of code during testing.',
              'tutorialLink': 'https://pub.dev/packages/mockito',
              'quizQuestions': [
                {
                  'question': 'Which package is used for mocking?',
                  'options': ['mockito', 'test', 'flutter_test', 'http'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the purpose of mocking?',
                  'options': [
                    'Isolate units of code',
                    'Improve performance',
                    'Simplify syntax',
                    'Reduce memory usage',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which annotation creates mocks?',
                  'options': [
                    '@GenerateMocks()',
                    '@Mock()',
                    '@CreateMocks()',
                    '@Generate()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you create mock object?',
                  'options': [
                    'Mock<ClassName>()',
                    'new MockClass()',
                    'createMock()',
                    'mock(Class)',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method verifies interactions?',
                  'options': ['verify()', 'expect()', 'assert()', 'check()'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you stub method responses?',
                  'options': [
                    'when().thenReturn()',
                    'mock.when()',
                    'stub.method()',
                    'setup.return()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method checks call count?',
                  'options': [
                    'verify().called()',
                    'verify().times()',
                    'verify().count()',
                    'verify().howMany()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you generate mock code?',
                  'options': [
                    'flutter pub run build_runner build',
                    'flutter pub get',
                    'flutter build',
                    'flutter generate',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of code generation?',
                  'options': [
                    'Type safety',
                    'Better performance',
                    'Less boilerplate',
                    'All of the above',
                  ],
                  'correctAnswerIndex': 3,
                },
                {
                  'question': 'Which method verifies never called?',
                  'options': [
                    'verifyNever()',
                    'verify().never()',
                    'neverVerify()',
                    'verifyZeroInteractions()',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Test Coverage',
              'description':
                  'Measure how much of your code is covered by tests to ensure quality and identify gaps.',
              'tutorialLink': 'https://flutter.dev/docs/testing/code-coverage',
              'quizQuestions': [
                {
                  'question': 'What is code coverage?',
                  'options': [
                    'Percentage of code tested',
                    'Number of tests written',
                    'Test execution time',
                    'Test success rate',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you generate coverage report?',
                  'options': [
                    'flutter test --coverage',
                    'flutter analyze',
                    'flutter doctor',
                    'flutter pub get',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which file contains coverage data?',
                  'options': [
                    'coverage/lcov.info',
                    'test/coverage.xml',
                    'reports/coverage.json',
                    'coverage/report.txt',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which tool visualizes coverage?',
                  'options': ['lcov', 'coverage', 'visualizer', 'reporter'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is a good coverage percentage?',
                  'options': ['80-90%', '50-60%', '100%', '30-40%'],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which lines are counted for coverage?',
                  'options': [
                    'Executable lines',
                    'Comment lines',
                    'Blank lines',
                    'Import lines',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you exclude files from coverage?',
                  'options': [
                    'lcov tool options',
                    'Delete files',
                    'Rename files',
                    'Move files',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which metric shows branch coverage?',
                  'options': [
                    'Branch coverage',
                    'Line coverage',
                    'Function coverage',
                    'Statement coverage',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of high coverage?',
                  'options': [
                    'Fewer bugs',
                    'Better performance',
                    'Smaller app size',
                    'Faster execution',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you view HTML coverage report?',
                  'options': [
                    'genhtml tool',
                    'Browser directly',
                    'IDE plugin',
                    'Mobile app',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
            {
              'name': 'Golden Tests',
              'description':
                  'Visually test UI by comparing screenshots to ensure pixel-perfect rendering across updates.',
              'tutorialLink': 'https://pub.dev/packages/golden_toolkit',
              'quizQuestions': [
                {
                  'question': 'What are golden tests?',
                  'options': [
                    'Visual regression tests',
                    'Unit tests',
                    'Integration tests',
                    'Widget tests',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method captures golden image?',
                  'options': [
                    'expectLater(tester.takeScreenshot())',
                    'tester.captureGolden()',
                    'goldenTest()',
                    'captureScreen()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Where are golden files stored?',
                  'options': [
                    'test/goldens/',
                    'assets/goldens/',
                    'images/goldens/',
                    'screenshots/',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you update golden files?',
                  'options': [
                    'flutter test --update-goldens',
                    'flutter goldens --update',
                    'flutter test --refresh',
                    'flutter update-goldens',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which package helps with golden tests?',
                  'options': [
                    'golden_toolkit',
                    'flutter_test',
                    'test',
                    'screenshot',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What is the benefit of golden tests?',
                  'options': [
                    'Catch visual regressions',
                    'Improve performance',
                    'Reduce code size',
                    'Simplify testing',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you handle platform differences?',
                  'options': [
                    'Platform-specific goldens',
                    'Ignore differences',
                    'Use single golden',
                    'Disable tests',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'Which method loads golden image?',
                  'options': [
                    'loadImage()',
                    'loadGolden()',
                    'getImage()',
                    'loadAsset()',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'What causes golden test failures?',
                  'options': [
                    'Pixel differences',
                    'Network errors',
                    'Database issues',
                    'Memory problems',
                  ],
                  'correctAnswerIndex': 0,
                },
                {
                  'question': 'How do you compare images in tests?',
                  'options': [
                    'expectLater() with matchesGoldenFile()',
                    'expect() with equals()',
                    'assert() with same()',
                    'verify() with match()',
                  ],
                  'correctAnswerIndex': 0,
                },
              ],
            },
          ],
          'quizQuestions': [
            {
              'question': 'Which package is used for testing?',
              'options': [
                'flutter_test',
                'test',
                'mockito',
                'All of the above',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'What is a widget test?',
              'options': [
                'Tests UI components',
                'Tests business logic',
                'Tests network requests',
                'Tests database operations',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which function defines a test?',
              'options': [
                'test()',
                'testWidgets()',
                'group()',
                'All of the above',
              ],
              'correctAnswerIndex': 3,
            },
            {
              'question': 'What is the purpose of expect()?',
              'options': [
                'To assert test conditions',
                'To create widgets',
                'To manage state',
                'To handle gestures',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which widget finds widgets by type?',
              'options': [
                'find.byType()',
                'find.byKey()',
                'find.text()',
                'find.byIcon()',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'What is a unit test?',
              'options': [
                'Tests individual functions',
                'Tests UI components',
                'Tests network requests',
                'Tests database operations',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which package is used for mocking?',
              'options': ['flutter_test', 'test', 'mockito', 'http'],
              'correctAnswerIndex': 2,
            },
            {
              'question': 'What is the purpose of pumpWidget()?',
              'options': [
                'To render a widget tree',
                'To create animations',
                'To manage state',
                'To handle gestures',
              ],
              'correctAnswerIndex': 0,
            },
            {
              'question': 'Which function groups related tests?',
              'options': ['test()', 'testWidgets()', 'group()', 'expect()'],
              'correctAnswerIndex': 2,
            },
            {
              'question': 'What is integration testing?',
              'options': [
                'Tests the entire app flow',
                'Tests individual functions',
                'Tests UI components',
                'Tests network requests',
              ],
              'correctAnswerIndex': 0,
            },
          ],
        },
      ],
    },
    'C': {
      'description':
          'C is a general-purpose programming language that is extremely popular, simple, and flexible to use.',
      'topics': [
        'Variables',
        'Control Statements',
        'Functions',
        'Arrays',
        'Pointers',
        'Structures',
      ],
    },
    'C++': {
      'description':
          'C++ is a powerful general-purpose programming language built on C, with object-oriented features.',
      'topics': [
        'Classes',
        'Objects',
        'Inheritance',
        'Polymorphism',
        'Templates',
        'STL',
      ],
    },
    'Java': {
      'description':
          'Java is a high-level, class-based, object-oriented programming language designed to have as few implementation dependencies as possible.',
      'topics': [
        'OOP Concepts',
        'Collections',
        'Multithreading',
        'JDBC',
        'Servlets',
        'Spring',
      ],
    },
    'Database': {
      'description':
          'Learn the fundamentals of database design and management for storing and retrieving data efficiently.',
      'topics': [
        'ER Models',
        'SQL',
        'Normalization',
        'Transactions',
        'Indexes',
        'Backup',
      ],
    },
    'MySQL': {
      'description':
          'MySQL is an open-source relational database management system that uses Structured Query Language (SQL).',
      'topics': [
        'DDL Commands',
        'DML Commands',
        'Joins',
        'Subqueries',
        'Views',
        'Stored Procedures',
      ],
    },
    'HTML': {
      'description':
          'HTML is the standard markup language for documents designed to be displayed in a web browser.',
      'topics': [
        'Tags',
        'Attributes',
        'Forms',
        'Tables',
        'Semantic HTML',
        'Accessibility',
      ],
    },
    'Python': {
      'description':
          'Python is an interpreted high-level general-purpose programming language with simple syntax.',
      'topics': [
        'Data Types',
        'Control Flow',
        'Functions',
        'Modules',
        'File Handling',
        'OOP',
      ],
    },
    'React': {
      'description':
          'React is a JavaScript library for building user interfaces, particularly single-page applications.',
      'topics': [
        'Components',
        'Props',
        'State',
        'Hooks',
        'Routing',
        'API Integration',
      ],
    },
    'Dart': {
      'description':
          'Dart is a client-optimized language for fast apps on any platform, developed by Google.',
      'topics': [
        'Syntax',
        'OOP',
        'Async Programming',
        'Collections',
        'Libraries',
        'Testing',
      ],
    },
  };
}
