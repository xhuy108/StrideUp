import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stride_up/core/common/cubits/navigation_cubit/navigation_cubit.dart';
import 'package:stride_up/core/common/widgets/navigation_menu.dart';
import 'package:stride_up/features/auth/bloc/auth_bloc.dart';
import 'package:stride_up/features/auth/pages/log_in_page.dart';
import 'package:stride_up/features/auth/pages/sign_up_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:stride_up/features/auth/repositories/auth_repository.dart';
import 'package:stride_up/utils/wallet_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WalletProvider walletProvider = WalletProvider();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => NavigationCubit(),
      ),
      BlocProvider(
        create: (_) => AuthBloc(
          authRepository: const AuthRepository(),
        ),
      ),
      ChangeNotifierProvider<WalletProvider>.value(value: walletProvider),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          home: FirebaseAuth.instance.currentUser == null
              ? const LoginPage()
              : const NavigationMenu(),
        );
      },
    );
  }
}
