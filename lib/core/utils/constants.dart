

const String _apiBaseUrl = 'http://smsloadbalancer-503714711.eu-central-1.elb.amazonaws.com/api'; // add the base url here
const String loginEndpoint = '$_apiBaseUrl/auth/login/';
const String checkTokenEndpoint = '$_apiBaseUrl/auth/user/';

const String loginErrorMessage =
    'Could not login successfully, please check your email and password';

const String noConnectionErrorMessage = 'You are not connected to the Internet';


const double defaultPagePadding = 20;


//routes
const String homeRoute = '/';
const String loginRoute = '/login';
