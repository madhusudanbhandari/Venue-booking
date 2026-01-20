// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/services/auth_service.dart';
// import 'package:flutter_application_1/services/user_services.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   String selectedRole = "Client";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up"), centerTitle: true),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const Text(
//                 "Create Account",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30),

//               TextFormField(
//                 controller: nameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your full name';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Full Name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//               const SizedBox(height: 15),

//               TextFormField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!value.contains('@')) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   prefixIcon: Icon(Icons.email),
//                 ),
//               ),
//               const SizedBox(height: 15),

//               TextFormField(
//                 controller: passwordController,
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//               ),
//               const SizedBox(height: 15),

//               DropdownButtonFormField<String>(
//                 value: selectedRole,
//                 items: const [
//                   DropdownMenuItem(value: "Client", child: Text("Client")),
//                   DropdownMenuItem(value: "Owner", child: Text("Venue Owner")),
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedRole = value!;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   labelText: "Register As",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 25),

//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // Handle signup logic
//                     if (_formKey.currentState!.validate()) {
//                       try {
//                         final authService = AuthService();
//                         final userService = UserServices();
//                         await authService.signin(
//                           emailController.text.trim(),
//                           passwordController.text.trim(),
//                         );
//                         await userService.saveUserData(
//                           name: nameController.text.trim(),
//                           email: emailController.text.trim(),
//                           role: selectedRole,
//                         );

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Signup validation successful'),
//                           ),
//                         );
//                       } catch (e) {
//                         ScaffoldMessenger.of(
//                           context,
//                         ).showSnackBar(SnackBar(content: Text(e.toString())));
//                       }
//                     }
//                   },
//                   child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String selectedRole = 'Client';

  void registerUser() {
    if (_formKey.currentState!.validate()) {
      final userData = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "phone": phoneController.text.trim(),
        "address": addressController.text.trim(),
        "role": selectedRole,
      };

      // For now, just printing
      debugPrint(userData.toString());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registration Successful")));

      // Later: Navigate to dashboard based on role
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Registration"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              /// FULL NAME
              TextFormField(
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? "Enter your full name" : null,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// EMAIL
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) return "Enter your email";
                  if (!value.contains('@')) return "Invalid email";
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// PASSWORD
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return "Enter password";
                  if (value.length < 6) return "Minimum 6 characters";
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// PHONE
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Enter phone number" : null,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// ADDRESS
              TextFormField(
                controller: addressController,
                maxLines: 2,
                validator: (value) => value!.isEmpty ? "Enter address" : null,
                decoration: const InputDecoration(
                  labelText: "Address",
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              /// ROLE SELECTION
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: const [
                  DropdownMenuItem(value: 'Client', child: Text('Client')),
                  DropdownMenuItem(value: 'Owner', child: Text('Owner')),
                ],
                onChanged: (value) {
                  setState(() => selectedRole = value!);
                },
                decoration: const InputDecoration(
                  labelText: "Register As",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              /// REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: registerUser,
                  child: const Text("REGISTER", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
