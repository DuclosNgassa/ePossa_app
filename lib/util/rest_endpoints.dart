const APP_URL =
    "https://play.google.com/store/apps/details?id=com.kmerconsulting.epossa_app";
const SITE_WEB = "https://www.kmerconsulting.com/";
const PRIVACY_POLICY_URL =
    "https://kmersoftdesign.wordpress.com/datenschutzerklarung/";

//const SERVER_URL = "https://epossa.kmerconsulting.com"; // Server
//const SERVER_URL = "http://10.2.17.228:8080/api"; // Office
const SERVER_URL = "http://192.168.2.120:8080"; // Home
const API_URL = SERVER_URL + "/api"; // Home

const URL_USERS = API_URL + "/users";
const URL_CHANGE_PASSWORD = URL_USERS + "/changepassword";
const URL_SIGNIN = URL_USERS + "/signin";
const URL_USERS_BY_PHONE = URL_USERS + "/phone/";
const URL_LOGIN = SERVER_URL + "/login";

const URL_PASSWORD_RESET = URL_USERS + "/resetpassword";

const URL_TRANSFERS = API_URL + "/transfers";
const URL_TRANSFERS_BY_SENDER = URL_TRANSFERS + "/sender/";
const URL_TRANSFERS_BY_RECEIVER = URL_TRANSFERS + "/receiver/";

const URL_USER_NOTIFICATION = API_URL + "/userNotification";
const URL_USER_NOTIFICATION_BY_EMAIL = URL_USER_NOTIFICATION + "/useremail/";
