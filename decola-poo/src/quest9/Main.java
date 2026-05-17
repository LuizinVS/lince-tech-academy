package quest9;

public class Main {
    public static void main(String[] args) {
        String texto = "exemplo de texto aqui";

        int vogais = 0;
        int consoantes = 0;
        int letras = 0;
        int palavras = 0;

        texto = texto.toLowerCase();

        for (int i = 0; i < texto.length(); i++) {

            char c = texto.charAt(i);

            if (c >= 'a' && c <= 'z') {
                letras++;

                if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                    vogais++;
                } else {
                    consoantes++;
                }
            }
        }

        String[] partes = texto.trim().split("\\s+");
        palavras = partes.length;

        System.out.println("Vogais: " + vogais);
        System.out.println("Consoantes: " + consoantes);
        System.out.println("Letras: " + letras);
        System.out.println("Palavras: " + palavras);
    }
}
