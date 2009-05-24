package ITK::MailBugs::Config;

# Database config
our $db_host = "localhost";
our $db_port = "5432";
our $db_name = "itkmailbugs";
our $db_username = "itkmailbugs";
our $db_password = "";

eval {
    require 'config.local.pm';
};
