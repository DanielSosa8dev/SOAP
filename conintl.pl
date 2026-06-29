use Mojolicious::Lite;
use Lingua::Num2Word;

# Ejecución: perl conintl.pl daemon
# URL de prueba: http://localhost:3000/conintl?n=100080

get '/conintl' => sub {
    my $c = shift;
    
    # Recibir el parámetro 'n' desde la URL
    my $n = $c->param('n') // 0;

    # Usar el método cardinal del módulo con el código de idioma español ('spa')
    my $res = Lingua::Num2Word::cardinal('spa', $n);

    # Retornar la respuesta en texto plano
    return $c->render(text => $res);
};

app->start;
