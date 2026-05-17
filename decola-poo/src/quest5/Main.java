package quest5;

public class Main {
    public static void main(String[] args) {
        double a = 1;
        double b = -5;
        double c = 6;

        double delta = (b * b) - (4 * a * c);

        if (delta < 0) {

            System.out.println("Nao existem raizes reais.");

        } else {

            double x1 = (-b + Math.sqrt(delta)) / (2 * a);
            double x2 = (-b - Math.sqrt(delta)) / (2 * a);

            System.out.println("X1 = " + x1);
            System.out.println("X2 = " + x2);
        }
    }
}
