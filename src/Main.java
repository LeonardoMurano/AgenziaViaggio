import controller.ApplicationController;
import exception.ApplicationException;

public class Main {

    public static void main(String[] args) {
        try {
            ApplicationController applicationController = new ApplicationController();
            applicationController.start();
        } catch (ApplicationException e) {
            System.err.println(e.getMessage());
            System.exit(1);
        }
    }
}