using System.Text;
using System.Text.RegularExpressions;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/clisoap2", async (long n = 0) => {
    // 1. Consumir el servicio SOAP
    string xmlPayload = $@"<?xml version=""1.0"" encoding=""utf-8""?>
    <soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
      <soap:Body>
        <NumberToWords xmlns=""http://www.dataaccess.com/webservicesserver/"">
          <ubiNum>{n}</ubiNum>
        </NumberToWords>
      </soap:Body>
    </soap:Envelope>";

    using var client = new HttpClient();
    client.DefaultRequestHeaders.Add("SOAPAction", "");
    
    var content = new StringContent(xmlPayload, Encoding.UTF8, "text/xml");
    var responseSOAP = await client.PostAsync("https://www.dataaccess.com/webservicesserver/NumberConversion.wso", content);
    var xmlResult = await responseSOAP.Content.ReadAsStringAsync();

    // Extraer el texto en inglés (con la corrección del prefijo m:)
    var match = Regex.Match(xmlResult, @"<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>");
    string textoIngles = match.Success ? match.Groups[1].Value.Trim() : "";

    if (string.IsNullOrEmpty(textoIngles)) return "Error al procesar el XML de origen.";

    // 2. Traducir el resultado de inglés a español
    string urlTraduccion = $"https://api.mymemory.translated.net/get?q={Uri.EscapeDataString(textoIngles)}&langpair=en|es";
    var responseAPI = await client.GetStringAsync(urlTraduccion);
    
    // 3. Extraer y retornar el texto traducido del JSON
    using var jsonDoc = JsonDocument.Parse(responseAPI);
    string textoEspanol = jsonDoc.RootElement.GetProperty("responseData").GetProperty("translatedText").GetString() ?? "";

    return textoEspanol.ToLower();
});

app.Run("http://localhost:3000");
