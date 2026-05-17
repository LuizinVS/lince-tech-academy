package quest7;

public class Main {
    public static void main(String[] args) {
        int n = 5;

        int fatorial = 1;

        for (int i = 1; i <= n; i++) {
            fatorial *= i;
        }

        System.out.println("Fatorial = " + fatorial);
    }
}
