import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with TickerProviderStateMixin {
  AnimationController? _withdrawalController;
  AnimationController? _balanceController;
  AnimationController? _creditController;
  AnimationController? _historyController;
  double currentBalance = 89.09;
  Color currentColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _withdrawalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _balanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _creditController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _historyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _performBalance();
  }

  @override
  void dispose() {
    _withdrawalController!.dispose();
    _creditController!.dispose();
    super.dispose();
  }

  void _performWithdrawal() {
    _withdrawalController!.forward().then((value) {
      _withdrawalController!.reverse();
    });
  }

  void _performBalance() {
    _balanceController!.forward().then((value) {
      _balanceController!.reverse();
      setState(() {
        currentColor = Colors.white;
      });
    });
    ;
  }

  void _performCredit() {
    _creditController!.forward().then((value) {
      _creditController!.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B8FF9),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF5B8FF9), Color(0xFFe634c2)],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 20,
              left: 20,
              child: Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 1.5).animate(
                  CurvedAnimation(
                    parent: _balanceController!
                        .drive(CurveTween(curve: Curves.easeOut)),
                    curve: Curves.easeOut,
                  ),
                ),
                child: Text(
                  '$currentBalance\$',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: currentColor,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: 20,
              right: 20,
              child: GlassmorphicContainer(
                height: 300,
                width: double.infinity,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFe634c2).withOpacity(0.5),
                    const Color(0xFF5B8FF9).withOpacity(0.5),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF5B8FF9).withOpacity(0.5),
                    const Color(0xFF5DAAE0).withOpacity(0.5),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(200, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent),
                      ),
                      onPressed: () {
                        _performWithdrawal();
                        _performBalance();
                        setState(() {
                          currentBalance = currentBalance - 2;
                          currentColor = Colors.redAccent;
                        });
                      },
                      icon: const Icon(Icons.remove),
                      label: const Text(
                        'Withdrawal',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(200, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.greenAccent),
                      ),
                      onPressed: () {
                        _performCredit();
                        _performBalance();
                        setState(() {
                          currentBalance = currentBalance + 2;
                          currentColor = Colors.greenAccent;
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Credit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 400,
              left: 20,
              right: 20,
              child: GlassmorphicContainer(
                height: 300,
                width: double.infinity,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF5B8FF9).withOpacity(0.5),
                    const Color(0xFF5DAAE0).withOpacity(0.5),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF5B8FF9).withOpacity(0.5),
                    const Color(0xFF5DAAE0).withOpacity(0.5),
                  ],
                ),
                child: const Text(
                  'Transaction details go here',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
