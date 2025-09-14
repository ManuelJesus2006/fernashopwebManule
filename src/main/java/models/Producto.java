package models;

import java.io.Serializable;
import java.util.Objects;

public class Producto implements Serializable {
    //Atributos
    private int id;
    private String marca;
    private String modelo;
    private String descripcion;
    private float precio;
    private int relevancia;

    //Constructor
    public Producto(int id, String marca, String modelo, String descripcion, float precio, int relevancia) {
        this.id = id;
        this.marca = marca;
        this.modelo = modelo;
        this.descripcion = descripcion;
        this.precio = precio;
        this.relevancia = relevancia;
    }

    //2do Constructor solo para visualizar en pedidos
    public Producto(int id, String marca, String modelo, float precio) {
        this.id = id;
        this.marca = marca;
        this.modelo = modelo;
        this.precio = precio;
    }

    //Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public int getRelevancia() {
        return relevancia;
    }

    public void setRelevancia(int relevancia) {
        this.relevancia = relevancia;
    }

    // Otros metodos
    @Override
    public String toString() {
        return "\t- " + marca + " - " + modelo + " (" + precio + ")";
    }

    public String getUrlImagen() {
        switch (modelo) {
            case "WH-1000XM5":
                return "https://m.media-amazon.com/images/I/61fxPWFu6aL.jpg";
            case "Hue Starter Kit":
                return "https://www.assets.signify.com/is/image/Signify/8719514291492-929002468810-Philips-Hue_WCA-9W-A60-E27-2set-EU-RTP";
            case "V15 Detect":
                return "https://m.media-amazon.com/images/I/51XFBTan1gL.jpg";
            case "ROG Zephyrus G14":
                return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShb9qoGBKA6ZquP-TuhHHTeM15sZHrfGAd4w&s";
            case "Galaxy S23":
                return "https://m.media-amazon.com/images/I/61+aq7q+FUL._UF1000,1000_QL80_.jpg";
            case "Serie 6 SMS68TI01E":
                return "https://static.fnac-static.com/multimedia/Images/FA/FA/73/55/5600250-1505-3756-1/tsp20250810133309/Bosch-Serie-6-Super-Silence-Plus-SMS68TI01E-Lave-vaielle-pose-libre-largeur-60-cm-profondeur-60-cm-hauteur-84-5-cm-Inox-argent.jpg";
            case "Spectre x360":
                return "https://m.media-amazon.com/images/I/51k4j6kS6fL.jpg";
            case "OLED55C3":
                return "https://m.media-amazon.com/images/I/61q+K8aPi6L.jpg";
            case "EOS R6":
                return "https://media.ldlc.com/r1600/ld/products/00/05/99/42/LD0005994283.jpg";
            case "MALM":
                return "https://www.ikea.com/es/es/images/products/malm-comoda-4-cajones-blanco__0484879_pe621344_s5.jpg";
            case "W Collection W7":
                return "https://www.vieffetrade.eu/shop/foto_articoli/Whirlpool/127100/127100-2.jpg";
            case "Echo Dot 5ª Gen":
                return "https://assets.mmsrg.com/isr/166325/c1/-/ASSET_MMS_98657830/fee_786_587_png";
            case "Air Max 270":
                return "https://cdn-images.farfetch-contents.com/12/83/31/75/12833175_21352537_600.jpg";
            case "Fenix 7":
                return "https://cdn.barrabes.com/product/XLarge/1129867.jpg";
            case "Artisan 5KSM150":
                return "https://thumbs.ielectro.es/product/med/014862.webp";
            case "Mi Electric Scooter 4 Pro":
                return "https://m.media-amazon.com/images/I/61k5iBneZnL.jpg";
            case "DCD796D2-QW":
                return "https://suministroscesarortega.com/wp-content/uploads/2024/07/714Hh1ADGfL._SL1500_.jpg";
            case "Surface Pro 9":
                return "https://m.media-amazon.com/images/I/51kpOnI-UoL._UF894,1000_QL80_.jpg";
            case "Ultraboost 22":
                return "https://cdn-images.farfetch-contents.com/19/43/49/22/19434922_43282895_1000.jpg";
            case "SoundLink Revolve+":
                return "https://m.media-amazon.com/images/I/71eJQYXTVxL.jpg";
            case "Switch OLED":
                return "https://img.pccomponentes.com/articles/43/432881/1945-nintendo-switch-oled-blanca.jpg";
            case "PlayStation 5":
                return "https://gmedia.playstation.com/is/image/SIEPDC/ps5-product-thumbnail-01-en-14sep21?$facebook$";
            case "Charge 6":
                return "https://m.media-amazon.com/images/I/71OAC2L15TL.jpg";
            case "Galaxy Watch 6":
                return "https://m.media-amazon.com/images/I/61Swv-UJIVL._UF1000,1000_QL80_.jpg";
            case "MacBook Pro 16":
                return "https://i.ebayimg.com/images/g/EGUAAOSwSWhjxdjA/s-l1200.jpg";
            case "MX Master 3":
                return "https://m.media-amazon.com/images/I/618IJzC-fFL.jpg";
            default:
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Imagen_no_disponible.svg/2048px-Imagen_no_disponible.svg.png";
        }
    }

    public String get(String tipoDeDatoACambiar) {
        switch (tipoDeDatoACambiar){
            case "marca": return marca;
            case "modelo": return modelo;
            case "descripcion": return descripcion;
            case "precio": return String.valueOf(precio);
            default: return null;
        }
    }
}

