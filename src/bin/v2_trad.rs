use axum::{routing::get, Router};

async fn traduccion_simulada() -> &'static str {
    // Simulamos el paso por MyMemory Translation
    "Traduccion JSON Simulada: cien mil ochenta"
}

#[tokio::main]
async fn main() {
    let app = Router::new().route("/clisoap2", get(traduccion_simulada));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8080").await.unwrap();
    
    println!("Servidor V2 (Traducción) en http://localhost:8080/clisoap2");
    axum::serve(listener, app).await.unwrap();
}
