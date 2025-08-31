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

    public String getUrlImagen(String modeloProducto) {
        switch (modeloProducto) {
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
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Bosch_SMS68TI01E_dishwasher.jpg/1200px-Bosch_SMS68TI01E_dishwasher.jpg";
            case "Spectre x360":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/HP_Spectre_x360_13-inch_2019.jpg/1200px-HP_Spectre_x360_13-inch_2019.jpg";
            case "OLED55C3":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/LG_OLED_TV.jpg/1200px-LG_OLED_TV.jpg";
            case "EOS R6":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Canon_EOS_R6_2020.jpg/1200px-Canon_EOS_R6_2020.jpg";
            case "MALM":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/IKEA_MALM_bed_with_storage.jpg/1200px-IKEA_MALM_bed_with_storage.jpg";
            case "W Collection W7":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Whirlpool_W_Collection_oven_W7_OM4_4_H_black.jpg/1200px-Whirlpool_W_Collection_oven_W7_OM4_4_H_black.jpg";
            case "Echo Dot 5ª Gen":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Amazon_Echo_Dot_5th_Gen.jpg/1200px-Amazon_Echo_Dot_5th_Gen.jpg";
            case "Air Max 270":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Nike_Air_Max_270.jpg/1200px-Nike_Air_Max_270.jpg";
            case "Fenix 7":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Garmin_Fenix_7.jpg/1200px-Garmin_Fenix_7.jpg";
            case "Artisan 5KSM150":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/KitchenAid_Artisan_Series_5KSM150_Stand_Mixer.jpg/1200px-KitchenAid_Artisan_Series_5KSM150_Stand_Mixer.jpg";
            case "Mi Electric Scooter 4 Pro":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Xiaomi_Mi_Electric_Scooter_4_Pro.jpg/1200px-Xiaomi_Mi_Electric_Scooter_4_Pro.jpg";
            case "DCD796D2-QW":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/DeWalt_DCD796D2-QW_cordless_drill.jpg/1200px-DeWalt_DCD796D2-QW_cordless_drill.jpg";
            case "Surface Pro 9":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Microsoft_Surface_Pro_9.jpg/1200px-Microsoft_Surface_Pro_9.jpg";
            case "Ultraboost 22":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Adidas_Ultraboost_22.jpg/1200px-Adidas_Ultraboost_22.jpg";
            case "SoundLink Revolve+":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Bose_SoundLink_Revolve%2B_portable_Bluetooth_speaker.jpg/1200px-Bose_SoundLink_Revolve%2B_portable_Bluetooth_speaker.jpg";
            case "Switch OLED":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Nintendo_Switch_OLED_model.jpg/1200px-Nintendo_Switch_OLED_model.jpg";
            case "PlayStation 5":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/PlayStation_5_console.jpg/1200px-PlayStation_5_console.jpg";
            case "Charge 6":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Fitbit_Charge_6.jpg/1200px-Fitbit_Charge_6.jpg";
            case "Galaxy Watch 6":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Samsung_Galaxy_Watch_6.jpg/1200px-Samsung_Galaxy_Watch_6.jpg";
            case "MacBook Pro 16":
                return "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/MacBook_Pro_16-inch_M2_Pro.jpg/1200px-MacBook_Pro_16-inch_M2_Pro.jpg";
            default:
                return "/images/producto-generico.png";
        }
    }
}

