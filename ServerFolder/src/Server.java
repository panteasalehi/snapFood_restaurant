import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
class RestaurantUser {
    //this class is just for the restaurant below are the things which are gotten from sign up page
    String name ;
    String phoneNum;
    String password ;
    String foodType;
    String address;
    //foods which are saved in a restaurant
    //static ArrayList<Food> foods;
    //keeping the address
    String n;
    String m;
    RestaurantUser(String phoneNum , String password) {
        this.phoneNum = phoneNum;
        this.password = password;
    }
    RestaurantUser(String name , String address , String foodType , String phoneNum , String password){
        this.password  =password;
        this.phoneNum = phoneNum;
        this.address = address;
        this.foodType = foodType;
        this.name = name;
    }
}
class ClientHandler implements Runnable{
    Socket s;
    DataOutputStream dos;
    DataInputStream dis;
    ClientHandler(Socket socket){
        s = socket;
        try {
             dis = new DataInputStream(s.getInputStream());
             dos = new DataOutputStream(s.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @Override
    public void run() {
            try {
                String read = dis.readLine();
                System.out.println(read);
              String[] command = read.split("the String is:");
               if(command[0].contains("signup")){
                   System.out.println("Request For Register");
                   String name = command[2];
                   String address=command[3];
                   String foodType=command[4];
                   String phoneNum=command[5];
                   String password =command[6];
                   System.out.println("name"+name+"address"+address+"foodType"+foodType+"phoneNum"+phoneNum+"password"+password);
                   RestaurantUser newUser = new RestaurantUser(name , address , foodType , phoneNum , password);

                   dos.writeUTF("true");
                   dos.flush();

               }

            } catch (IOException e) {
                e.printStackTrace();
            }

    }
}
public class Server{
    public static void main(String[] args) {
        try {
            ServerSocket ss = new ServerSocket(1122);
            while (true){
                Socket s = ss.accept();
                System.out.println("client connected");
                Thread client = new Thread(new ClientHandler(s));
                client.start();
            }


        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}