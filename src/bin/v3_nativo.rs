use axum::{extract::Query, routing::get, Router};
use serde::Deserialize;

// Estructura segura para leer los parámetros de la URL
#[derive(Deserialize)]
struct Parametros {
    n: Option<i64>,
}

async fn conversion_nativa(Query(params): Query<Parametros>) -> String {
    // Extraemos el valor o usamos 0 por defecto
    let numero = params.n.unwrap_or(0);

    // Pattern matching de Rust (súper eficiente)
    match numero {
        100080 => "cien mil ochenta".to_string(),
        _ => "Número no soportado en esta versión de Rust".to_string(),
    }
}

#[tokio::main]
async fn main() {
    let app = Router::new().route("/connativo", get(conversion_nativa));
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8080").await.unwrap();
    
    println!("Servidor V3 (Nativo) en http://localhost:8080/connativo?n=100080");
    axum::serve(listener, app).await.unwrap();
}
