# import 'dart:convert';
import 'package:http/http.dart' as http


class Api {
    final String baseUrl = 'http://localhost:5000'
    // Substitua pelo endereço do seu servidor

    Future < String > createUser(String username, String email, String password) async {
        final response = await http.post(Uri.parse('$baseUrl/user'),
                                         headers: {'Content-Type': 'application/json'},
                                         body: jsonEncode({'username': username, 'email': email, 'password': password}))

        if (response.statusCode == 200) {
            return 'success'
        } else {
            return 'error'
        }
    }

    Future < String > login(String email, String password) async {
        final response = await http.post(Uri.parse('$baseUrl/login'),
                                         headers: {'Content-Type': 'application/json'},
                                         body: jsonEncode({'email': email, 'password': password}))

        if (response.statusCode == 200) {
            return 'success'
        } else {
            return 'error'
        }
    }

    Future < String > saveDescription(String description) async {
        final response = await http.post(Uri.parse('$baseUrl/description'),
                                         headers: {'Content-Type': 'application/json'},
                                         body: jsonEncode({'description': description}))

        if (response.statusCode == 200) {
            final jsonResponse = jsonDecode(response.body)
            final location = jsonResponse['location']
            return location
        } else {
            return 'error'
        }
    }
}

# retorno


final api = Api()

final result = await api.createUser('johndoe', 'johndoe@example.com', 'password')
print(result)
// success ou error

final result = await api.login('johndoe@example.com', 'password')
print(result)
// success ou error

final result = await api.saveDescription('Uma descrição qualquer')
print(result)
// latitude, longitude ou error
