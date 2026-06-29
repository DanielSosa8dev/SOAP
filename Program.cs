using Humanizer;
using System.Globalization;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/connativo", (long n = 0) => {
    // Utilizar Humanizer con la cultura en español ('es') para la conversión directa
    string resultadoLetras = n.ToWords(new CultureInfo("es"));
    
    return resultadoLetras;
});

app.Run("http://localhost:3000");
