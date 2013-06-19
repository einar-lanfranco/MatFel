package MatFel::Controller::Mail;

#Este modulo provee funcionalidades varias para el mail

use parent 'Catalyst::Controller';
use strict;
use warnings;
require Exporter;
use Mail::Sendmail;
use Net::SMTP;
use Net::SMTP::SSL;
use Net::SMTP::TLS;
use Time::Zone;

use vars qw(@EXPORT @ISA);
@ISA=qw(Exporter);
@EXPORT=qw(&send_mail );


# TODO pasar a preferencias????

use constant SMTP_TIME_OUT  => 5;
use constant DEBUG          => 1;

sub send_mail_TLS {
    my ($mail_hash_ref) = @_;
    my $mailer  = 0;
    my $ok      = 0;
    my $msg_error;

    eval {
        $mailer = new Net::SMTP::TLS (  
                                            $mail_hash_ref->{'smtp_server'},  
                                            Hello       => $mail_hash_ref->{'smtp_server'},  
                                            Port        => $mail_hash_ref->{'smtp_port'},  
                                            User        => $mail_hash_ref->{'smtp_user'},  
                                            Password    => $mail_hash_ref->{'smtp_pass'},
                                            Timeout     => SMTP_TIME_OUT,    
                                            Debug       => DEBUG,
                                    );
    
        if ( not $mailer ) {
            $ok = 0;
            $msg_error = "Mail => send_mail_TLS => No se pudo conectar con el servidor: ".$mail_hash_ref->{'smtp_server'};
#             $c->log->debug($msg_error);  
        } else {
            $mailer->mail($mail_hash_ref->{'mail_from'});
            $mailer->to($mail_hash_ref->{'mail_to'});
            $mailer->data;  
            $mailer->datasend("From: " . $mail_hash_ref->{'mail_from'} . "\n");
            $mailer->datasend("To: " . $mail_hash_ref->{'mail_to'} . "\n");
            $mailer->datasend("Subject: " . $mail_hash_ref->{'mail_subject'} . "\n");
            $mailer->datasend("Date: " . $mail_hash_ref->{'mail_date'}. "\n");
            $mailer->datasend("\n");
            $mailer->datasend($mail_hash_ref->{'mail_message'}. "\n");
            $mailer->dataend;  
            $mailer->quit;
            $ok = 1;
        }  
    };

    if($@){
        $msg_error = "Mail => send_mail_TLS => error => $@";
#         $c->log->debug($msg_error);
        $ok = 0;
        $msg_error = "Mail => send_mail_TLS => Error al intentar conectar con el servidor";
    }

#     $c->log->debug("Mail => send_mail_TLS => return => ".$ok);

    return ($ok, $msg_error);
}


sub send_mail_SSL {
    my ($mail_hash_ref) = @_;


    my $mailer = 0;
    my $ok;
    my $msg_error;
    eval {
        $mailer = new Net::SMTP::SSL (  
                                            $mail_hash_ref->{'smtp_server'},  
                                            Hello       => $mail_hash_ref->{'smtp_server'},  
                                            Port        => $mail_hash_ref->{'smtp_port'},  
                                            User        => $mail_hash_ref->{'smtp_user'},  
                                            Password    => $mail_hash_ref->{'smtp_pass'},
                                            Timeout     => SMTP_TIME_OUT,
                                            Debug       => DEBUG
                                    );
    
        if ( not $mailer ) {
            $ok = 0;
            $msg_error = "Mail => send_mail_SSL => No se pudo conectar con el servidor: ".$mail_hash_ref->{'smtp_server'};
#             $c->log->debug($msg_error);  
        } else {
            $mailer->mail($mail_hash_ref->{'mail_from'});
            $mailer->to($mail_hash_ref->{'mail_to'});
            $mailer->data;  
            $mailer->datasend("From: " . $mail_hash_ref->{'mail_from'} . "\n");
            $mailer->datasend("To: " . $mail_hash_ref->{'mail_to'} . "\n");
            $mailer->datasend("Subject: " . $mail_hash_ref->{'mail_subject'} . "\n");
            $mailer->datasend("Date: " .$mail_hash_ref->{'mail_date'} . "\n");
            $mailer->datasend("\n");
            $mailer->datasend($mail_hash_ref->{'mail_message'} . "\n");

            $mailer->dataend;  
            $mailer->quit;
            $ok = 1;
        }  
    };

    if($@){
        $msg_error = "Mail => send_mail_SSL => error => $@";
#         $c->log->debug($msg_error);
        $msg_error = "Mail => send_mail_SSL => Error al intentar conectar con el servidor";
    }

#     $c->log->debug("Mail => send_mail_SSL => return => ".$ok);

    return ($ok, $msg_error);
}


sub send_mail_PLANO {
    my ($mail_hash_ref,$c) = @_;
    my $mailer = 0;
    my $ok;
    my $msg_error;
    my @data;

    eval {
        $mailer = new Net::SMTP (  
                                            $mail_hash_ref->{'smtp_server'},  
                                            Hello       => $mail_hash_ref->{'smtp_server'},  
                                            Port        => $mail_hash_ref->{'smtp_port'},  
                                            Timeout     => SMTP_TIME_OUT,
                                            Debug       => DEBUG
                                    );
        if ( not $mailer ) {
            $ok = 0;
            $msg_error = "Mail => send_mail_PLANO => No se pudo conectar con el servidor: ".$mail_hash_ref->{'smtp_server'};
             $c->log->debug($msg_error);  
        } else {
            $ok = $mailer->mail($mail_hash_ref->{'mail_from'});
            if (!$ok) {
                $msg_error = " Error en mail_from: ".$mail_hash_ref->{'mail_from'};
                 $c->log->debug("Mail => send_mail_SENDMAIL => mail_from => OK:       ".$ok);
                return ($ok, $msg_error);
            }

            $ok = $mailer->recipient($mail_hash_ref->{'mail_to'});
            if (!$ok) {
                $msg_error = " Error en mail_to: ".$mail_hash_ref->{'mail_to'};
                 $c->log->debug("Mail => send_mail_SENDMAIL => mail_to => OK:       ".$ok);
                return ($ok, $msg_error);
            }
            $mailer->mail($mail_hash_ref->{'mail_from'});
            $mailer->to($mail_hash_ref->{'mail_to'});
            $mailer->data;  
            $mailer->datasend("From: " . $mail_hash_ref->{'mail_from'} . "\n");
            $mailer->datasend("To: " . $mail_hash_ref->{'mail_to'} . "\n");
            $mailer->datasend("Subject: " . $mail_hash_ref->{'mail_subject'} . "\n");
            $mailer->datasend("Date: " .$mail_hash_ref->{'mail_date'} . "\n");
            $mailer->datasend("\n");
            $mailer->datasend($mail_hash_ref->{'mail_message'} . "\n");
            $mailer->dataend;  
            $mailer->quit;
            $ok = 1;
        }  
    };

    if($@){
        $msg_error = "Mail => send_mail_PLANO => error => $@";
         $c->log->debug($msg_error);
        $msg_error = "Mail => send_mail_PLANO => Error al intentar conectar con el servidor";
    }

     $c->log->debug("Mail => send_mail_PLANO => return => ".$ok);
    
    return ($ok, $msg_error);
}

sub send_mail_SENDMAIL {
    my ($mail_hash_ref) = @_;
    my $mailer = 0;
    my $ok;
    my $msg_error;

    eval {

        if($mail_hash_ref->{'smtp_server_sendmail'}) {
            #se envia el mail con SENDMAIL
            my %mail = (    To      => $mail_hash_ref->{'mail_to'},
                            From    => $mail_hash_ref->{'mail_from'},
                            Subject => $mail_hash_ref->{'mail_subject'},
                            Date    => $mail_hash_ref->{'mail_date'},
                            Message => $mail_hash_ref->{'mail_message'}
                        );

            if ($mail_hash_ref->{'mail_to'} && $mail_hash_ref->{'mail_from'} ){

                if(sendmail(%mail)) {
#                     $c->log->debug("Mail => send_mail_SENDMAIL => SE ENVIO MAIL A: ".$mail_hash_ref->{'mail_to'});
                    $ok = 1;
                } else {
#                     $c->log->debug("Mail => send_mail_SENDMAIL => FALLO EL SENDMAIL !!");
                    $ok = 0;
                }
            }
        }
    };

    if($@){
        $msg_error = "Mail => send_mail_SENDMAIL => error => $@";
#         $c->log->debug($msg_error);
        $msg_error = "Mail => send_mail_SENDMAIL => Error al intentar conectar con el servidor";
    }

#     $c->log->debug("Mail => send_mail_SENDMAIL => return => ".$ok);

    return ($ok, $msg_error);
}

sub send_mail_TEST {
    my ($mail_to) = @_;

    my %mail;
    my $ok          = 0;
    my $msg_error   = "Error inesperado";

    #$mail{'mail_from'}              = C4::Context->preference("mailFrom");
    $mail{'mail_to'}                = $mail_to;
    $mail{'mail_subject'}           = Encode::decode('utf8', "Prueba de configuración de mail");
    $mail{'mail_message'}           = "Esta es una prueba de configuraci".chr(243)."n del mail";
    $mail{'mail_date'}   = date_r();
    eval {

        #($ok, $msg_error)           = &C4::AR::Mail::send_mail(\%mail);

        if($ok){    
            $msg_error              = Encode::decode('utf8',"Se envió el mail a la cuenta (".$mail_to.")");
        }

    };

    return ($ok, $msg_error);
}
=item sub date_r
    Esta funcion nos devuelve la hora en el formato que se usa para el encabezado del mail
=cut
 sub date_r
    {
        my ($day, $mon, $str);
        my (@lt) = ();
        my @MON = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
        my @DAYS = qw(Sun Mon Tue Wed Thu Fri Sat Sun); 
        @lt     = localtime();
        $day    = $lt[6];
        $mon    = $lt[4];

        $str = $DAYS[$day] . ", " . $lt[3] . " " . $MON[$mon] . " " . ($lt[5]+1900)
             . " " . sprintf("%02d:%02d:%02d", $lt[2], $lt[1], $lt[0] )
            . " " . sprintf("%03d%02d", (tz_offset() / 3600), 0);

        return $str;
    }



=item
    sub send_mail

    Envia un mail a $mail_to con subject $mail_subject, mensaje $mail_message

@params
    $info_smtp_hash_ref => para enviar datos para testear la configuracion

    $mail_hash_ref->{'smtp_server'}     =>  servidor SMTP al que se va a conectar
    $mail_hash_ref->{'smtp_metodo'}     =>  metodo de encriptacion para autenticacion SSL/TLS/PLANO
    $mail_hash_ref->{'smtp_port'}       =>  puerto del servidor SMTP al que se va a conectar
    $mail_hash_ref->{'smtp_user'}       =>  usuario del mail en el servidor SMTP al cual se va a conectar
    $mail_hash_ref->{'smtp_pass'}       =>  password del usuario del mail en el servidor SMTP al cual se va a conectar
    $mail_hash_ref->{'mail_from'}       =>  from del mail a enviar (de quien es el mail)
    $mail_hash_ref->{'mail_to'})        =>  to del mail a enviar (a quien va dirigido)
    $mail_hash_ref->{'mail_subject'}    =>  asunto del mail
    $mail_hash_ref->{'mail_message'}    =>  mensaje del mail

=cut
sub send_mail {
    my ($info_smtp_hash_ref,$mensaje,$to,$c) = @_;
    my $mailer          = 0;
    my $ok              = 0;
    my $msg_error;

    # Servidores SMTP
    # yahoo     => smtp.mail.yahoo.com.ar 465 SSL
    # gmail     => smtp.gmail.com 587 TLS
    # hotmail   => smtp.live.com 25 TLS
    # hotmail   => smtp.live.com 587 SSL
    # linti     => mail.linti.unlp.edu.ar 25 TLS
    $info_smtp_hash_ref->{'mail_to'}=$to;
    $info_smtp_hash_ref->{'mail_subject'}="Reporte Diario";
    $info_smtp_hash_ref->{'mail_message'}=$mensaje;
    $info_smtp_hash_ref->{'mail_date'} = date_r();
    if ($info_smtp_hash_ref->{'smtp_metodo'} eq "SENDMAIL") {
        #se envia el mail con SENDMAIL
        ($ok, $msg_error) =  send_mail_SENDMAIL($info_smtp_hash_ref);
    } else {
        if ($info_smtp_hash_ref->{'smtp_metodo'} eq "TLS") {
            ($ok, $msg_error) =  send_mail_TLS($info_smtp_hash_ref);
        }elsif ($info_smtp_hash_ref->{'smtp_metodo'} eq "SSL") {
            ($ok, $msg_error) =  send_mail_SSL($info_smtp_hash_ref);
        }elsif ($info_smtp_hash_ref->{'smtp_metodo'} eq "PLANO") {
            ($ok, $msg_error) =  send_mail_PLANO($info_smtp_hash_ref,$c);
        }#END if($mail_metodo eq "PLANO")
    }

    return ($ok, $msg_error);
}


END { }       # module clean-up code here (global destructor)

1;
__END__

