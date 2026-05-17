package quest10;
public class Main {
    public static void main(String[] args) {

        int[] numeros = {5, 2, 9, 1, 6};

        int soma = 0;
        int somaPares = 0;
        int somaImpares = 0;

        int maior = numeros[0];
        int menor = numeros[0];

        int n = numeros.length;

        for (int i = 0; i < n; i++) {

            int valor = numeros[i];

            soma += valor;

            if (valor % 2 == 0) {
                somaPares += valor;
            } else {
                somaImpares += valor;
            }

            if (valor > maior) {
                maior = valor;
            }

            if (valor < menor) {
                menor = valor;
            }
        }

        int[] crescente = new int[n];
        int[] decrescente = new int[n];

        for (int i = 0; i < n; i++) {
            crescente[i] = numeros[i];
            decrescente[i] = numeros[i];
        }

        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1 - i; j++) {

                if (crescente[j] > crescente[j + 1]) {
                    int temp = crescente[j];
                    crescente[j] = crescente[j + 1];
                    crescente[j + 1] = temp;
                }
            }
        }

        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - 1 - i; j++) {

                if (decrescente[j] < decrescente[j + 1]) {
                    int temp = decrescente[j];
                    decrescente[j] = decrescente[j + 1];
                    decrescente[j + 1] = temp;
                }
            }
        }

        System.out.print("Crescente: ");
        for (int i = 0; i < n; i++) {
            System.out.print(crescente[i] + " ");
        }

        System.out.println();

        System.out.print("Decrescente: ");
        for (int i = 0; i < n; i++) {
            System.out.print(decrescente[i] + " ");
        }

        System.out.println();

        System.out.println("Maior: " + maior);
        System.out.println("Menor: " + menor);
        System.out.println("Soma: " + soma);
        System.out.println("Media: " + (double) soma / n);
        System.out.println("Soma pares: " + somaPares);
        System.out.println("Soma impares: " + somaImpares);
    }
}
