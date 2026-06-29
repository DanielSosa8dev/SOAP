using System.Text;
using System.Text.RegularExpressions;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/clisoap1", async (long n = 0) => {
    // 1. Construir el XML (Sobre SOAP)
    string xmlPayload = $@"<?xml version=""1.0"" encoding=""utf-8""?>
    <soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
      <soap:Body>
        <NumberToWords xmlns=""http://www.dataaccess.com/webservicesserver/"">
          <ubiNum>{n}</ubiNum>
        </NumberToWords>
      </soap:Body>
    </soap:Envelope>";

    using var client = new HttpClient();
    
    // Algunos servidores SOAP exigen este encabezado aunque esté vacío
    client.DefaultRequestHeaders.Add("SOAPAction", "");
    
    var content = new StringContent(xmlPayload, Encoding.UTF8, "text/xml");
    var response = await client.PostAsync("https://www.dataaccess.com/webservicesserver/NumberConversion.wso", content);
    var xmlResult = await response.Content.ReadAsStringAsync();

    // 2. Extraer el resultado tolerando el prefijo <m:>
    var match = Regex.Match(xmlResult, @"<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>");
    
    // Si tiene éxito, devolvemos el texto. Si falla, devolvemos el XML crudo para ver qué envió el servidor.
    return match.Success ? match.Groups[1].Value.Trim() : $"Error. Respuesta cruda del servidor: {xmlResult}";
});

app.Run("http://localhost:3000");
