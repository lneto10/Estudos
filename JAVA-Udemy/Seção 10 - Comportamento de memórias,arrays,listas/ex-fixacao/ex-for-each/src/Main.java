public class Main {
    public static void main(String[] args) {


        String[] vect = new String[] {"Luiz", "Carol","Bob"};

        /*for (int i = 0;i<vect.length;i++){
            System.out.println(vect[i]);
        }*/

        //usando o for-each

        for(String obj : vect){
            System.out.println(obj);
        }
    }
}