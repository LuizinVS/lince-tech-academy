package quest4;

public class Main {
    public static void main(String[] args) {
        double n1 = 4;
        double n2 = 6;

        int maior;

        if (n1 > n2) {
            maior = (int) n1;
        } else {
            maior = (int) n2;
        }

        while (true) {

            if (maior % n1 == 0 && maior % n2 == 0) {
                System.out.println("MMC = " + maior);
                break;
            }

            maior++;
        }
    }
}
