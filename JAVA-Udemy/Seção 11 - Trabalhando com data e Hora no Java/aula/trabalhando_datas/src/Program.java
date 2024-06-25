import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
public class Program {


    public static void main(String[] args) {
        LocalDate d01 = LocalDate.now();
        LocalDateTime d02 = LocalDateTime.now();
        Instant d03 = Instant.now();
        LocalDate d04 = LocalDate.parse("2022-06-24");
        LocalDateTime d05 = LocalDateTime.parse("2022-06-24T20:57:45");


        System.out.println("D01 - "+d01);
        System.out.println("D02 - "+d02);
        System.out.println("D03 - "+d03);
        System.out.println("D04 - "+d04);
        System.out.println("D05 - "+d05);

    }

}
