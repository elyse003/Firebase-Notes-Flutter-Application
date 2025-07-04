class LoginScreen extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('Login/Signup')),
      body: Column(
        children: [
          TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          ElevatedButton(
            child: Text('Sign Up'),
            onPressed: () async {
              try {
                await authCubit.signUp(emailCtrl.text, passCtrl.text);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Error: $e')));
              }
            },
          ),
          ElevatedButton(
            child: Text('Login'),
            onPressed: () async {
              try {
                await authCubit.login(emailCtrl.text, passCtrl.text);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Error: $e')));
              }
            },
          ),
        ],
      ),
    );
  }
}
