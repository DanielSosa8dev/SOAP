use Mojolicious::Lite;
use SOAP::Lite;
use Mojo::UserAgent;
use Mojo::Util qw(url_escape);

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

get '/clisoap2' => sub {
    my $c = shift;
    my $n = $c->param('n') // 0;

    # 1. Consumir el servicio SOAP
    my $soap = SOAP::Lite
        ->proxy('https://www.dataaccess.com/webservicesserver/NumberConversion.wso')
        ->ns('http://www.dataaccess.com/webservicesserver/', 'm');
    my $som = $soap->NumberToWords(SOAP::Data->name('ubiNum' => $n));
    my $texto_ingles = $som->result // '';

    # 2. Traducir el resultado de inglés a español usando la API de MyMemory
    my $ua = Mojo::UserAgent->new;
    my $url = "https://api.mymemory.translated.net/get?q=" . url_escape($texto_ingles) . "&langpair=en|es";
    my $tx = $ua->get($url);

    my $texto_espanol = $tx->result->json('/responseData/translatedText') // $texto_ingles;

    # 3. Retornar el resultado traducido
    return $c->render(text => lc($texto_espanol));
};

app->start;
