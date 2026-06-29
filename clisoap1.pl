use Mojolicious::Lite;
use SOAP::Lite;

# Desactivar la verificación estricta de SSL para mitigar bloqueos en Windows
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

get '/clisoap1' => sub {
    my $c = shift;
    my $n = $c->param('n') // 0;

    # Configurar el cliente SOAP apuntando al servicio de DataAccess
    my $soap = SOAP::Lite
        ->proxy('https://www.dataaccess.com/webservicesserver/NumberConversion.wso')
        ->ns('http://www.dataaccess.com/webservicesserver/', 'm');

    # Realizar la llamada a la operación NumberToWords
    my $som = $soap->NumberToWords(SOAP::Data->name('ubiNum' => $n));

    if ($som->fault) {
        return $c->render(text => "Error en el servicio SOAP: " . $som->faultstring);
    } else {
        my $resultado = $som->result;
        return $c->render(text => $resultado);
    }
};

app->start;
