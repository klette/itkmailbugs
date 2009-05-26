use strict;
use warnings;
use utf8;

use Email::Valid;
use Mail::Message;
use Mail::Transport::SMTP;

require 'config.pm';

package ITK::MailBugs;

sub db_connect {
    my $dbh = DBI->connect("dbi:Pg:".
        "dbname=" . $ITK::MailBugs::Config::db_name . ";".
        "host="   . $ITK::MailBugs::Config::db_host,
        $ITK::MailBugs::Config::db_username,
        $ITK::MailBugs::Config::db_password)
        or die "Unable to connect to database with error: " .
            DBI::errstr();
    $dbh->{RaiseError} = 1;
    $dbh->{TaintIn} = 1;
    $dbh->{AutoCommit} = 0;

    return $dbh;
}

sub create_project {
    my ($project_name, $email, $dbh) = @_;

    if ($dbh->do("INSERT INTO project (project_name, email) VALUES (?,?)",
        undef, $project_name, $email)){
            return 1;
        } else {
            return 0;
        }
}

sub project_exists {
    my ($project_name, $dbh) = @_;
    my @res = $dbh->fetchrow_array("SELECT COUNT(*) FROM project WHERE project_name = ?",
        undef, $project_name);
    if ($res[0] > 0){
        return 1;
    }
    return 0;
}

sub create_bug {
    my ($title, $details, $creator, $dbh) = @_;
    $dbh->do("INSERT INTO bug (title, description, created_by)
              VALUES (?,?,?)", undef, $title, $details, $creator);
}

sub comment_bug {
    my ($bug, $text, $creator, $dbh) = @_;
    $dbh->do("INSERT INTO bug_comment ()")
}

1;

