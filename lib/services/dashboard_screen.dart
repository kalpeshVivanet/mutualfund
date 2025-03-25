// // import 'package:flutter/material.dart';
// // import 'package:mutual_fund/screens/auth_service.dart';
// // import 'package:provider/provider.dart';

// // import '../widgets/performance_chart.dart';

// // class DashboardScreen extends StatefulWidget {
// //   const DashboardScreen({Key? key}) : super(key: key);

// //   @override
// //   _DashboardScreenState createState() => _DashboardScreenState();
// // }

// // class _DashboardScreenState extends State<DashboardScreen> {
// //   // Sample data - in real app, this would come from an API or database
// //   final List<double> _navData = [
// //     100.0, 102.5, 101.8, 103.2, 105.6, 
// //     104.9, 106.3, 108.1, 107.5, 109.2
// //   ];

// //   final List<String> _dateLabels = [
// //     'Jan', 'Feb', 'Mar', 'Apr', 'May', 
// //     'Jun', 'Jul', 'Aug', 'Sep', 'Oct'
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     final authService = context.watch<AuthService>();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Mutual Fund Dashboard'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.logout),
// //             onPressed: () {
// //               authService.signOut();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Welcome, ${authService.currentUser?.email ?? 'User'}',
// //                 style: Theme.of(context).textTheme.headlineSmall,
// //               ),
// //               const SizedBox(height: 16),
// //               const Text(
// //                 'Fund Performance',
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               MutualFundPerformanceChart(
// //                 navData: _navData,
// //                 dateLabels: _dateLabels,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:mutual_fund/screens/auth_service.dart';
// import 'package:provider/provider.dart';

// import '../widgets/performance_chart.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   // More comprehensive and realistic sample data
//   final Map<String, List<MapEntry<String, double>>> _performanceData = {
//     '1M': [
//       MapEntry('Jan', 100.0),
//       MapEntry('Feb', 102.5),
//       MapEntry('Mar', 105.2),
//     ],
//     '3M': [
//       MapEntry('Nov', 98.0),
//       MapEntry('Dec', 100.5),
//       MapEntry('Jan', 102.5),
//       MapEntry('Feb', 105.2),
//       MapEntry('Mar', 107.8),
//     ],
//     '6M': [
//       MapEntry('Aug', 95.0),
//       MapEntry('Sep', 97.5),
//       MapEntry('Oct', 100.0),
//       MapEntry('Nov', 102.5),
//       MapEntry('Dec', 105.2),
//       MapEntry('Jan', 107.8),
//     ],
//     '1Y': [
//       MapEntry('Apr', 90.0),
//       MapEntry('Jul', 95.0),
//       MapEntry('Oct', 100.0),
//       MapEntry('Jan', 105.2),
//     ],
//     'All': [
//       MapEntry('2023 Q1', 90.0),
//       MapEntry('2023 Q2', 95.0),
//       MapEntry('2023 Q3', 100.0),
//       MapEntry('2023 Q4', 105.2),
//       MapEntry('2024 Q1', 109.5),
//     ]
//   };

//   @override
//   Widget build(BuildContext context) {
//     final authService = context.watch<AuthService>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mutual Fund Dashboard'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               authService.signOut();
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildWelcomeHeader(authService),
//               const SizedBox(height: 16),
//               _buildFundSummary(),
//               const SizedBox(height: 16),
//               const Text(
//                 'Fund Performance',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               MutualFundPerformanceChart(
//                 performanceData: _performanceData,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeHeader(AuthService authService) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome, ${authService.currentUser?.email ?? 'User'}',
//               style: TextStyle(fontSize: 18),
              
//             ),
//             const Text(
//               'Your Investment Overview',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//         const CircleAvatar(
//           backgroundColor: Colors.blue,
//           child: Icon(Icons.person, color: Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildFundSummary() {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildSummaryItem('Total Investment', '₹50,000', Colors.blue),
//             _buildSummaryItem('Current Value', '₹54,250', Colors.green),
//             _buildSummaryItem('Gain', '+8.5%', Colors.green),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryItem(String title, String value, Color color) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: const TextStyle(color: Colors.grey),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             color: color,
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mutual_fund/screens/auth_service.dart';
import 'package:provider/provider.dart';

import '../widgets/performance_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // More comprehensive and realistic sample data
  final Map<String, List<MapEntry<String, double>>> _performanceData = {
    '1M': [
      MapEntry('Jan', 100.0),
      MapEntry('Feb', 102.5),
      MapEntry('Mar', 105.2),
    ],
    '3M': [
      MapEntry('Nov', 98.0),
      MapEntry('Dec', 100.5),
      MapEntry('Jan', 102.5),
      MapEntry('Feb', 105.2),
      MapEntry('Mar', 107.8),
    ],
    '6M': [
      MapEntry('Aug', 95.0),
      MapEntry('Sep', 97.5),
      MapEntry('Oct', 100.0),
      MapEntry('Nov', 102.5),
      MapEntry('Dec', 105.2),
      MapEntry('Jan', 107.8),
    ],
    '1Y': [
      MapEntry('Apr', 90.0),
      MapEntry('Jul', 95.0),
      MapEntry('Oct', 100.0),
      MapEntry('Jan', 105.2),
    ],
    'All': [
      MapEntry('2023 Q1', 90.0),
      MapEntry('2023 Q2', 95.0),
      MapEntry('2023 Q3', 100.0),
      MapEntry('2023 Q4', 105.2),
      MapEntry('2024 Q1', 109.5),
    ]
  };

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Fund Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutConfirmationDialog(context, authService);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeHeader(authService),
              const SizedBox(height: 16),
              _buildFundSummary(),
              const SizedBox(height: 16),
              const Text(
                'Fund Performance',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              MutualFundPerformanceChart(
                performanceData: _performanceData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context, AuthService authService) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(ctx).pop();
              
              // Perform logout
              authService.signOut();
              
              // Navigate to login screen
              context.go('/');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(AuthService authService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${authService.currentUser?.email ?? 'User'}',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Your Investment Overview',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildFundSummary() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryItem('Total Investment', '₹50,000', Colors.blue),
            _buildSummaryItem('Current Value', '₹54,250', Colors.green),
            _buildSummaryItem('Gain', '+8.5%', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}